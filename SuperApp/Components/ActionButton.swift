//
//  ActionButton.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 16/08/23.
//

import UIKit

class ActionButton: UIButton {
    var tapAction: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        
        setGestureAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setGestureAction() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAction)))
    }
    
    @objc private func didTapAction(_ gesture: UIGestureRecognizer) {
        tapAction?()
    }
}
