//
//  LoginViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 24/08/23.
//

import Foundation
import SwiftUI
import Then
import Combine

final class LoginViewController: DefaultViewController {
    
    private lazy var emailTextField = UITextField().then {
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.placeholder = "email"
        $0.keyboardType = .emailAddress
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 8
        $0.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 0)))
        $0.leftViewMode = .always
        $0.delegate = self
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.spellCheckingType = .no
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.placeholder = "password"
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 8
        $0.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 0)))
        $0.leftViewMode = .always
        $0.rightView = passwordLeftView
        $0.rightViewMode = .always
        $0.delegate = self
    }
    
    private let loginButton = ActionButton().then {
        $0.titleLabel?.font = .boldSystemFont(ofSize: 18)
        $0.setTitle("Login", for: .normal)
        $0.setTitleColor(.label, for: .normal)
        $0.layer.borderColor = UIColor.label.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 8
    }
    
    private let showPasswordButton = ActionButton().then {
        $0.setTitle("Show", for: .normal)
        $0.setTitleColor(.label, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }
    
    private lazy var passwordLeftView = UIStackView().then {
        $0.addArrangedSubviews([showPasswordButton])
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 10)
    }
    
    private lazy var inputStack = UIStackView().then {
        $0.addArrangedSubviews([emailTextField, passwordTextField])
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    @Published private var emailText: String = ""
    @Published private var passwordText: String = ""
    
    private var isShowPassword: Bool = false {
        didSet {
            togglePasswordShow()
        }
    }
    
    private let validation = Validation()
    private var keyboardRect: CGRect = .zero
    private var bags = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        setupSubviews()
        setupConstraints()
        setupSubscriptions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        togglePasswordShow()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    private func setupSubviews() {
        view.addSubviews([inputStack, loginButton])
        
        showPasswordButton.tapAction = { [weak self] in
            self?.isShowPassword.toggle()
        }
    }
    
    private func setupConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        inputStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        setLoginButtonConstraints()
    }
    
    private func setLoginButtonConstraints() {
        loginButton.snp.remakeConstraints { make in
            make.height.equalTo(50)
            make.top.greaterThanOrEqualTo(inputStack.snp.bottom).inset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            
            if keyboardRect != .zero {
                make.bottom.equalToSuperview().inset(keyboardRect.height + 20)
            } else {
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            }
        }
        
        view.layoutIfNeeded()
    }
    
    private func setupSubscriptions() {
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .assign(to: &$emailText)

        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
            .map { ($0.object as? UITextField)?.text ?? "" }
            .assign(to: &$passwordText)
    
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero }
            .sink { keyboardRect in
                self.keyboardRect = keyboardRect
                self.setLoginButtonConstraints()
            }
            .store(in: &bags)
        
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { $0.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect ?? .zero }
            .sink { keyboardRect in
                self.keyboardRect = .zero
                self.setLoginButtonConstraints()
            }
            .store(in: &bags)
        
        Publishers.CombineLatest($emailText, $passwordText)
            .eraseToAnyPublisher()
            .map { [weak self] (emailText, passwordText) in
                self?.emailText = emailText.replacingOccurrences(of: " ", with: "")
                self?.passwordText = emailText.replacingOccurrences(of: " ", with: "")
                
                guard let self = self else {
                    self?.emailTextField.layer.borderColor = UIColor.label.cgColor
                    self?.passwordTextField.layer.borderColor = UIColor.label.cgColor
                    return false
                }
                
                print(emailText, passwordText)
                let isValidEmail = validation.isValid(email: emailText)
                let isValidPassword = validation.isValidPassword(password: passwordText)
                
                emailTextField.layer.borderColor = emailText.isEmpty || isValidEmail ? UIColor.label.cgColor : UIColor.red.cgColor
                passwordTextField.layer.borderColor = passwordText.isEmpty || isValidPassword ? UIColor.label.cgColor : UIColor.red.cgColor
                
                return isValidEmail && isValidPassword
            }
            .sink { [weak self] (isVaid: Bool) in
                self?.loginButton.backgroundColor = isVaid ? .clear : .lightGray
                self?.loginButton.isEnabled = isVaid
            }
            .store(in: &bags)
        
    }
    
    private func togglePasswordShow() {
        passwordTextField.isSecureTextEntry = !isShowPassword
        showPasswordButton.setTitle( isShowPassword ? "hide" : "show", for: .normal)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


struct LoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        LoginViewControllerPreview.makeViewController()
    }
    
    static func makeViewController() -> some View {
        DefaultViewControllerRepresentable(LoginViewController())
    }
}
