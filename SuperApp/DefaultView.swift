//
//  DefaultView.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit

class DefaultView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        commonInit()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {}
    func setupSubviews() {}
    func setupConstraints() {}
}
