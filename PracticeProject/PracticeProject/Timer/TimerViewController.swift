//
//  TimerViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import UIKit

class TimerViewController: UIViewController {
    
    var tableView: UITableView!
    var timer: Timer?
    var record: [(time:Double, status:Bool)] = [(time:Double, status:Bool)].init(repeating: (time: 0.0, status: true), count: 50)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupTableView()
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    func setupTableView(){
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    func startTimer() {
        timer =  Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {
            _ in
            for cell in self.tableView.visibleCells {
                if let cell = cell as? TableViewCell {
                    cell.updateCellLabel()
                }
            }
        })
    }
    
}

extension TimerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell ?? TableViewCell()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            cell.updateStatus()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TableViewCell {
            record[indexPath.row] = (time:cell.getTime(), status:cell.getStatus())
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TableViewCell {
            cell.setTime(time: record[indexPath.row].time)
            cell.setStatus(status: record[indexPath.row].status)
        }
    }
    
    
    
}
