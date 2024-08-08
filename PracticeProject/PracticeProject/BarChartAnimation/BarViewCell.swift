//
//  BarViewCell.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-07.
//

import UIKit

class BarCell: UICollectionViewCell {

    static let identifier = "BarCell"

    var barView: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addBarView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        if let heightContrain = barView.constraints.first(where: {$0.firstAttribute == .height}) {
            heightContrain.isActive = false
        }
    }

    func addBarView(){
        barView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(barView)
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            barView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            barView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
        ])
    }

    func configCell(bar: Bar) {
        barView.backgroundColor = bar.color
        animationHeight(to: bar.nomlizedHeight * self.layer.bounds.height)
    }

    func animationHeight(to height: CGFloat) {
        barView.anchorPoint = CGPoint(x: 0.5, y: 1)
        let heightAnimation = CABasicAnimation(keyPath: "bounds.size.height")
        heightAnimation.delegate = self
        heightAnimation.fromValue = 0
        heightAnimation.toValue = height
        heightAnimation.duration = 2.5
        heightAnimation.fillMode = .removed
        heightAnimation.isRemovedOnCompletion = true
        barView.layer.add(heightAnimation, forKey: "heightAnimation")
    }
}

extension BarCell: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag,
        let animimation = anim as? CABasicAnimation,
        animimation.keyPath == "bounds.size.height",
        let height = animimation.toValue as? CGFloat {
            barView.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            barView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
