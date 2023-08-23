//
//  HeroListView.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 23/08/23.
//

import UIKit
import Then

protocol HeroListViewDelegate: AnyObject {
    func didSelectHero(_ hero: HeroDetail)
}

final class HeroListView: DefaultView {
    
    private lazy var searchBar = UISearchBar().then {
        $0.delegate = self
        $0.placeholder = "search hero name"
    }
    
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.register(HeroListCell.self, forCellReuseIdentifier: "HeroListCell")
    }
    
    private var heroes = [HeroDetail]() {
        didSet {
            filteredHeroes = heroes
        }
    }
    
    private var filteredHeroes = [HeroDetail]()
    
    weak var delegate: HeroListViewDelegate?
    
    override func commonInit() {
    }
    
    override func setupSubviews() {
        addSubviews([
            searchBar,
            tableView
        ])
    }
    
    override func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func setHeroes(_ heroes: [HeroDetail]) {
        self.heroes = heroes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HeroListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHero = filteredHeroes[indexPath.row]
        delegate?.didSelectHero(selectedHero)
    }
}

extension HeroListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroListCell", for: indexPath) as? HeroListCell else {
            return UITableViewCell()
        }
        
        let hero = filteredHeroes[indexPath.row]
        cell.configureCell(hero: hero)
        cell.selectionStyle = .none
        return cell
    }
}

extension HeroListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        defer {
            tableView.reloadData()
        }
        
        guard !searchText.isEmpty else {
            filteredHeroes = heroes
            return
        }
        
        filteredHeroes = heroes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
}
