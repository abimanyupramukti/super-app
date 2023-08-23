//
//  HeroDetailAttributeCell.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 23/08/23.
//

import UIKit

final class HeroDetailAttributeCell: UICollectionViewCell {
    
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = .label
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private let valueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .label
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private lazy var mainStack = UIStackView().then {
        $0.addArrangedSubviews([titleLabel, valueLabel])
        $0.axis = .vertical
        $0.layer.borderColor = UIColor.label.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(mainStack)
    }
    
    private func setupConstraints() {
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(title: String, value: Double) {
        titleLabel.text = title
        valueLabel.text = String(format: "%.1f", value*100) + "%"
    }
}
