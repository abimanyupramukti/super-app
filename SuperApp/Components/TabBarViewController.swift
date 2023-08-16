//
//  TabBarViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit

class TabBarViewController: DefaultViewController {
    func setTabBarItem(title: String, image: UIImage?) {
        let tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        self.tabBarItem = tabBarItem
        self.title = title
    }
}
