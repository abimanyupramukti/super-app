//
//  HeroListCell.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 21/08/23.
//

import UIKit
import Then

final class HeroListCell: UITableViewCell {
    
    private let nameLabel = UILabel().then {
        $0.textColor = .label
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    private let primaryAttrLabel = UILabel().then {
        $0.textColor = .label
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let attackTypeLabel = UILabel().then {
        $0.textColor = .label
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let rolesLabel = UILabel().then {
        $0.textColor = .label
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let heroImage = UIImageView().then {
        $0.tintColor = .label
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var nameStack = UIStackView().then {
        $0.addArrangedSubviews([nameLabel, primaryAttrLabel, attackTypeLabel])
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 4
    }
    
    private lazy var detailStack = UIStackView().then {
        $0.addArrangedSubviews([nameStack, rolesLabel])
        $0.spacing = 2
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
    }
    
    private lazy var mainStack = UIStackView().then {
        $0.addArrangedSubviews([detailStack, heroImage])
        $0.layer.borderColor = UIColor.label.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
            make.edges.equalToSuperview().inset(4)
        }
    }
    
    func configureCell(hero: HeroDetail) {
        heroImage.image = UIImage(systemName: "questionmark.square")
        nameLabel.text = hero.localizedName
        primaryAttrLabel.text = hero.primaryAttr.title
        primaryAttrLabel.textColor = hero.primaryAttr.color
        attackTypeLabel.text = hero.attackType.icon
        rolesLabel.text = hero.roles.enumerated().reduce(into: "") { $0 += $1.offset == hero.roles.indices.last ? $1.element : $1.element + " | " }

        heroImage.setImage(from: OpenDotaEndpoint.image(path: hero.icon))
    }
}
