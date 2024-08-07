//
//  TicTacToeColletionViewCell.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-06.
//

import UIKit

class TicTacToeColletionViewCell: UICollectionViewCell {
    
    static let identifier = "TicTacToeColletionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cellTappedClosure: ((TicTacToeColletionViewCell) -> Void)?
    
    func setupUI() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 5.0
    }
    
}
