//
//  HeroListViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 21/08/23.
//

import UIKit
import Then

final class HeroListViewController: TabBarViewController {
    
    private lazy var heroListView = HeroListView().then {
        $0.delegate = self
    }
    
    private var heroes = [HeroDetail]() {
        didSet {
            heroListView.setHeroes(heroes)
        }
    }
    
    private let dotaService = OpenDotaAPIService()
    private let decoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = heroListView
        setTabBarItem(title: "Dota", image: UIImage(systemName: "gamecontroller"))
        
        fetchData()
    }
    
    private func fetchData() {
        dotaService.fetch(.heroStats) { [weak self] result in
            switch result {
            case .success(let data):
                self?.heroes = (try? self?.decoder.decode([HeroDetail].self, from: data)) ?? []
            case .failure(let error):
                print("error fetching heroStats data: \(error.localizedDescription)")
            }
        }
    }
}

extension HeroListViewController: HeroListViewDelegate {
    func didSelectHero(_ hero: HeroDetail) {
        let detailViewController = HeroDetailViewController(hero: hero)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
