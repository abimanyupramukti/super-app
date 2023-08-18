//
//  JobListViewController.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 16/08/23.
//

import UIKit
import SwiftUI

final class JobListViewController: UITableViewController {
    
    private lazy var addItemButton = ActionButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 30
        $0.layer.shadowRadius = 30
        $0.tintColor = .white
        
        $0.tapAction = { [weak self] in
            self?.didTapButton()
        }
    }
    
    private var jobs: [Job] = []
    private let dataManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleText = "ToDo"
        tabBarItem = UITabBarItem(title: titleText, image: UIImage(systemName: "case"), tag: 0)
        title = titleText
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        view.addSubview(addItemButton)
        setupConstraints()
        
        fetchData()
    }
    
    private func setupConstraints() {
        addItemButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
    
    private func fetchData() {
        jobs = dataManager.fetch(type: Job.self)
        tableView.reloadData()
    }
    
    private func didTapButton(job: Job? = nil) {
        var view = JobInputView(job: job)
        view.delegate = self
        let jobInputViewController = UIHostingController(rootView: view)
        present(jobInputViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let job = jobs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.contentConfiguration = UIHostingConfiguration { JobListCellView(job: job) }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        jobs[indexPath.row].isDoneValue.toggle()
        dataManager.save()
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            dataManager.delete(object: jobs[indexPath.row])
            fetchData()
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completion) in
            guard let self = self else { return }
            didTapButton(job: jobs[indexPath.row])
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

extension JobListViewController: JobInputViewDelegate {
    func didFinished() {
        fetchData()
    }
}
