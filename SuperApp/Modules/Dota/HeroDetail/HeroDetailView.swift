//
//  HeroDetailView.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 23/08/23.
//

import UIKit
import Then

final class HeroDetailView: DefaultView {
    
    private lazy var imageView = UIImageView().then {
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(systemName: "person.circle")
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textColor = .white
    }
    
    private let iconView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var identityStack = UIStackView().then {
        $0.addArrangedSubviews([nameLabel, iconView])
        $0.distribution = .equalSpacing
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 10
        $0.scrollDirection = .vertical
    }
    
    private lazy var detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.dataSource = self
        $0.delegate = self
        $0.clipsToBounds = false
        $0.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        $0.register(HeroDetailAttributeCell.self, forCellWithReuseIdentifier: "HeroDetailAttributeCell")
    }
    
    private let hero: HeroDetail
    private var detailAttributes = [(String, Double)]()
    
    private var initialMovedItemCenter = CGPoint()
    
    init(hero: HeroDetail) {
        self.hero = hero
        
        super.init()
        
        constructAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func commonInit() {
        nameLabel.text = hero.localizedName
        iconView.setImage(from: OpenDotaEndpoint.image(path: hero.icon))
        imageView.setImage(from: OpenDotaEndpoint.image(path: hero.img))
    }
    
    override func setupSubviews() {
        addSubviews([
            imageView,
            detailCollectionView
        ])
        
        imageView.addSubview(identityStack)
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(200)
        }
        
        detailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        iconView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        identityStack.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    private func constructAttributes() {
        detailAttributes.append(contentsOf: [
            ("1", Double(hero.proWin) / Double(hero.proPick)),
            ("2", Double(hero.turboWINS) / Double(hero.turboPicks)),
            ("3", Double(hero.proWin)),
            ("4", Double(hero.turboWINS))
        ])
    }
}

extension HeroDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let column = Double(2)
        let row = ceil(Double(detailAttributes.count) / column)
        let maxSize = collectionView.frame.size
        let padding = Double(2 * 16)
        let spacing = (column-1) * 10
        let width = (maxSize.width - padding - spacing) / column
        let height = (maxSize.height - padding) / row
        return CGSize(width: width, height: height)
    }
}

extension HeroDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.moveItem(at: indexPath, to: IndexPath(row: 0, section: 0))
    }
}

extension HeroDetailView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailAttributes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroDetailAttributeCell", for: indexPath) as? HeroDetailAttributeCell else {
            return UICollectionViewCell()
        }
        
        let attribute = detailAttributes[indexPath.row]
        cell.configureCell(title: attribute.0, value: attribute.1)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanGesture))
        cell.addGestureRecognizer(panGesture)
        return cell
    }
    
    @objc private func didPanGesture(_ gesture: UIPanGestureRecognizer) {
        let item = gesture.view
        item?.layer.zPosition = 1
        let positionChanges = gesture.translation(in: item?.superview)
        
        switch gesture.state {
        case .began:
            initialMovedItemCenter = item?.center ?? .zero
        case .ended:
            let endPoint = CGPoint(x: initialMovedItemCenter.x + positionChanges.x, y: initialMovedItemCenter.y + positionChanges.y)
            
            if let startIndexPath = detailCollectionView.indexPathForItem(at: initialMovedItemCenter),
               var endIndexPath = detailCollectionView.indexPathForItem(at: endPoint),
               startIndexPath != endIndexPath {
                
                detailCollectionView.moveItem(at: startIndexPath, to: endIndexPath)
                endIndexPath.row += startIndexPath.row > endIndexPath.row ? 1 : -1
                detailCollectionView.moveItem(at: endIndexPath, to: startIndexPath)
                
            } else {
                item?.center = initialMovedItemCenter
            }
            
            initialMovedItemCenter = .zero
            item?.layer.zPosition = 0
            
        default:
            item?.center.x = initialMovedItemCenter.x +  positionChanges.x
            item?.center.y = initialMovedItemCenter.y + positionChanges.y
        }
    }
}
