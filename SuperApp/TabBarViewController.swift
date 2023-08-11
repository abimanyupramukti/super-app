//
//  TabBarViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit

class TabBarViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {}
    
    func setTabBarItem(title: String, image: UIImage?) {
        let tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        self.tabBarItem = tabBarItem
        self.title = title
    }
}
