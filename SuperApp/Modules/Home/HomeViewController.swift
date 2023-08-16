//
//  HomeViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit
import Then

final class HomeViewController: TabBarViewController {
    
    private lazy var homeView = HomeView().then {
        $0.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItem(title: "Home", image: UIImage(systemName: "house"))
        
        view = homeView
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapBottomsheet() {
        let bottomsheetVC = BottomsheetViewController()
        present(bottomsheetVC, animated: true)
    }
}
