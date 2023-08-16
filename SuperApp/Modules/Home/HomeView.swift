//
//  HomeView.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit
import SnapKit

protocol HomeViewDelegate: AnyObject {
    func didTapBottomsheet()
}

final class HomeView: DefaultView {
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }()
    
    weak var delegate: HomeViewDelegate?
    
    override func commonInit() {
        setupSubviews()
        setupConstraints()
        
        setupMainStack()
    }
    
    override func setupSubviews() {
        addSubview(mainStack)
    }
    
    override func setupConstraints() {
        mainStack.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(safeAreaLayoutGuide)
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setupMainStack() {
        mainStack.addArrangedSubviews([
            makeActionButton(title: "Bottomsheet") { [weak self] in self?.delegate?.didTapBottomsheet() },
        ])
    }
    
    private func makeActionButton(title: String, _ action: @escaping () -> Void) -> UIButton {
        let button = ActionButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 8 
        button.tapAction = action
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        return button
    }
}
