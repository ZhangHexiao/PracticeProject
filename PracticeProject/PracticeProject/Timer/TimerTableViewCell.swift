//
//  TimerTableViewCell.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TimerTableViewCell"
    var timerLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var isActive: Bool =  true
    var time: Double = 0.0
    
    override func prepareForReuse() {
        time = 0.0
        isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(){
        timerLable.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(timerLable)
        NSLayoutConstraint.activate([
            timerLable.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            timerLable.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            timerLable.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0)])
        timerLable.text = "0.0"
    }
    
    func updateCellLabel(){
        if(isActive) {
            time += 0.1
            timerLable.text = String(format: "%0.1f", time)
        }
    }
    
    func updateStatus(){
        isActive = !isActive
    }
    
    func getTime() -> Double{
        return time
    }
    
    func setTime(time:Double){
        self.time = time
        timerLable.text = String(format: "%0.1f", time)
    }
    
    func getStatus() -> Bool {
        return isActive
    }
    
    func setStatus(status: Bool){
        self.isActive = status
    }
           
    
}
