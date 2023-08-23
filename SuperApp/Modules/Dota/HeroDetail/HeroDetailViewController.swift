//
//  HeroDetailViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 21/08/23.
//

import UIKit
import Then
import SnapKit
import SwiftUI

final class HeroDetailViewController: DefaultViewController {
    
    private let heroDetailView: HeroDetailView
    
    init(hero: HeroDetail) {
        self.heroDetailView = HeroDetailView(hero: hero)
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = heroDetailView
        hidesBottomBarWhenPushed = true
    }
}
