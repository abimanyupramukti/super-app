//
//  DefaultViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit

class DefaultViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
