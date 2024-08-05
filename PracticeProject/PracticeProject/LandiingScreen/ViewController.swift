//
//  ViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-03.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    let indexLog:[[(title:String, navigation:UIViewController.Type)]] = [
        
        [
            (title: "Collection View With Image", navigation: CollectionImageViewController.self),
            (title: "Search Your Hero", navigation: StarWarViewController.self),
            (title: "Recipe List Take Home Test", navigation: RecipeListViewController.self),
            (title: "Timmer", navigation: TimerViewController.self)
//            (title: "Graph", navigation: "GraphController"),
//            (title: "AnimationChart", navigation: "AnimationController")
        ],
//        [
//            (title: "Tic-tac-toe Game", navigation: "ThreeQueenController"),
//            (title: "Beer Category with Search", navigation: "HomeScreenViewController"),
//            (title: "Concurrency download image", navigation: "ImageMatrixViewController"),
//            (title: "Beer Content Detail", navigation: "CombineViewController"),
//        ]
    ]
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(LandingCell.self, forCellReuseIdentifier: LandingCell.identifier)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return indexLog.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexLog[section].count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LandingCell.identifier, for: indexPath) as? LandingCell ?? LandingCell()
        
        cell.configCell(pageName: indexLog[indexPath.section][indexPath.row].title)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(indexLog[indexPath.section][indexPath.row].navigation.init(),animated:true)
        return
    }
}

