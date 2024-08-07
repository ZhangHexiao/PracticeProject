//
//  AnimationUIViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-06.
//

import UIKit
//This type of UI animation is like fadding in and fadding out

class AnimationUIViewController: UIViewController {
    
    private let switchDataButton = {
        let switchDataButton = UIButton()
        switchDataButton.setTitle("switch", for: .normal)
        switchDataButton.backgroundColor = .blue
        switchDataButton.tintColor = .clear
        switchDataButton.layer.cornerRadius = 8
        switchDataButton.translatesAutoresizingMaskIntoConstraints = false
        return switchDataButton
    }()
    
    
    private let background = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
 
    var barChartView: BarChartView!
    
    var data: [(UIColor, CGFloat)] = [
        (.blue, 20),
        (.red, 90),
        (.green, 50)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpBackgroundView()
//        barChartView = BarChartView(frame: view.bounds)
//        barChartView.autoresizingMask = [.flexibleWidth]
        barChartView = BarChartView(frame: CGRect(x: 20, y: 100, width: 335, height: 200))
        barChartView.backgroundColor = .lightGray
        barChartView.data = data
        background.addSubview(barChartView)
        setUpButton()
    }
    
    func setUpBackgroundView(){
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            background.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            background.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            background.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    func setUpButton(){
        switchDataButton.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        view.addSubview(switchDataButton)
        NSLayoutConstraint.activate([
            switchDataButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            switchDataButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            switchDataButton.widthAnchor.constraint(equalToConstant: 100),
            switchDataButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    @objc func buttonPress(){
        let newData: [(UIColor, CGFloat)] = [
            (.blue, 50),
            (.red, 10),
            (.green, 70)
        ]
        
        // ************update the UI direactly************
        // barChartView.data = newData
        // ************update the UI with transition************
        UIView.transition(with: barChartView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.barChartView.data = newData
        }, completion: nil)
    }
}

class BarChartView: UIView {
    var data: [(color: UIColor, height: CGFloat)] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        subviews.forEach { $0.removeFromSuperview() }
        // Calculate maximum height
        let maxBarHeight = data.map { $0.1 }.max() ?? 0
        guard maxBarHeight > 0 else { return }
        
        // Draw bars with animation
        for (index, (color, height)) in data.enumerated() {
            let barWidth = rect.width / CGFloat(data.count)
            let barHeight = (height / maxBarHeight) * rect.height
            
            let barView = UIView(frame: CGRect(x: CGFloat(index) * barWidth, y: rect.height - barHeight, width: barWidth, height: barHeight))
            barView.backgroundColor = color
            addSubview(barView)
            
            // Apply animation
            UIView.animate(withDuration: 0.5, delay: 0.1 * Double(index), options: .curveEaseInOut, animations: {
                barView.frame.size.height = barHeight
                barView.frame.origin.y = rect.height - barHeight
                self.setNeedsDisplay()
            }, completion: nil)
        }
    }
}
