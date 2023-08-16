//
//  BottomsheetView.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit
import SnapKit

protocol BottomsheetViewDelegate: AnyObject {
    func didCloseBottomsheet()
}

final class BottomsheetView: DefaultView {
    
    private let handleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let contentView: UIView
    
    private var initialCenter = CGPoint()
    
    weak var delegate: BottomsheetViewDelegate?
    
    init(contentView: UIView) {
        self.contentView = contentView
        
        super.init()
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanView))
        addGestureRecognizer(panGesture)
        
        addSubviews([
            handleView,
            contentView
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundTopCorners()
    }
    
    override func setupConstraints() {
        handleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(8)
            make.height.equalTo(8)
            make.width.equalTo(44)
        }
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.top.equalToSuperview().inset(20)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func roundTopCorners() {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 8, height: 8))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    @objc func didPanView(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        let translation = gestureRecognizer.translation(in: view.superview)
        
        switch gestureRecognizer.state {
        case .began:
            initialCenter = view.center
            
        case .ended:
            let halfHeight = view.frame.height * 0.5
            if view.center.y > initialCenter.y + halfHeight {
                delegate?.didCloseBottomsheet()
            } else {
                view.center = initialCenter
            }
            
        default:
            if translation.y > 0 {
                view.center = CGPoint(x: initialCenter.x, y: initialCenter.y + translation.y)
            } else {
                view.center = initialCenter
            }
        }
    }
}
