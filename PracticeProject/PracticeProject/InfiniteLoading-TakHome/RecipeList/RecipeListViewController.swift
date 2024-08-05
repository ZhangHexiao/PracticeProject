//
//  RecipeListViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation
import UIKit

class RecipeListViewController:  UIViewController {
    
    @UsesAutoLayout
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecipeViewCell.self, forCellReuseIdentifier: RecipeViewCell.identifier)
        return tableView
    }()
    
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    let noDataLabel: UILabel = UILabel()
    
    var viewModel: RecipeListViewModel = RecipeListViewModel(recipeService: RecipeService())
    
    override func viewDidLoad() {
        view.backgroundColor = .secondarySystemBackground
        setUpTitle()
        setUpTableView()
        viewModel.delegate = self
        viewModel.fetchData()
    }
    
    func setUpTitle(){
        navigationItem.title = "The Culinary Companion"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = .white
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
    }
    
    func setUpTableView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        noDataLabel.font = UIFont.boldSystemFont(ofSize: 14)
        noDataLabel.text = "All data loaded"
        noDataLabel.textAlignment = .center
        
        tableView.tableFooterView = spinner
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            if viewModel.currentPage < 5 {
                spinner.startAnimating()
                self.viewModel.fetchData()
            }
        }
    }
}

extension RecipeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LayoutDimension.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeViewCell.identifier, for: indexPath) as? RecipeViewCell ?? RecipeViewCell()
        
        cell.configCell(recipt: viewModel.recipeList[indexPath.row])
        if let imageURL = viewModel.recipeList[indexPath.row].smallImage?.url {
            viewModel.loadImageForCell(imageURL: imageURL, cell: cell)
        }
        return cell
    }
}

extension RecipeListViewController: RecipeListViewModelDelegate{
    func viewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
}

