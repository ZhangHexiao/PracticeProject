//
//  StarWarPersonViewCell.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import UIKit

class StarWarPersonViewCell: UITableViewCell {

    static let identifier = "StarWarPersonViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI() {
        contentView.layer.borderWidth = 10
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.lightGray
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
        ])
    }
    
    func configCell(person: Person) {
        self.nameLabel.text = person.name
    }
   
}
