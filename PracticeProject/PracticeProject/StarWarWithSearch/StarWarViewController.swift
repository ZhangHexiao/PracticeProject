//
//  StarWarViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation
import UIKit

class StarWarViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Input keywoard"
        return searchBar
    }()
    
    var viewModel = StarWarViewModel(networkService: StarWarNetworkManager.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = UIColor.white
        setupTableView()
        setupSearchBar()
        viewModel.fetchData()
    }
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(StarWarPersonViewCell.self, forCellReuseIdentifier: StarWarPersonViewCell.identifier)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
    func setupSearchBar() {
        searchBar.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 50)
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.backgroundImage = UIImage()
    }
}

extension StarWarViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.personList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StarWarPersonViewCell.identifier, for: indexPath) as? StarWarPersonViewCell ?? StarWarPersonViewCell()
        cell.configCell(person: viewModel.personList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
     
}

extension StarWarViewController: StarWarViewModelDelegate {
    func didLoadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension StarWarViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else{
            return
        }
        if (text == ""){
            return
        }
        viewModel.searchData(query: text)
        return
    }
}
