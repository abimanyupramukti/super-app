//
//  HomeView.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit
import SnapKit
import Then

protocol HomeViewDelegate: AnyObject {
    func didTapBottomsheet()
}

final class HomeView: DefaultView {
    
    private let mainStack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
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
        return ActionButton().then {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.label, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.label.cgColor
            $0.layer.cornerRadius = 8
            $0.tapAction = action
            $0.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
}
