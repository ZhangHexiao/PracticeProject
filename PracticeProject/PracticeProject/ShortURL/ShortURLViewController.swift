//
//  ShortURLViewController.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-06.
//

import UIKit



class ShortURLViewController: UIViewController, ShortURLViewModelDelegate {
    
    private let viewModel =  ShortURLViewModel(networkService: ShortURLNetworkManager.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        viewModel.delegate = self
        setUpUI()
        confrimButton.addTarget(self, action: #selector(sendOurURL), for: .touchUpInside)
    }
    
    var input: UITextField = {
        let input = UITextField()
        input.layer.borderWidth = 1
        input.layer.borderColor = UIColor.lightGray.cgColor
        return input
    }()
    
    var resultLable: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.text = "Please input your URL"
        return label
    }()
    
    var confrimButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirmmation", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.backgroundColor = .green
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    func setUpUI(){
        
        input.translatesAutoresizingMaskIntoConstraints = false
        confrimButton.translatesAutoresizingMaskIntoConstraints = false
        resultLable.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(input)
        view.addSubview(confrimButton)
        view.addSubview(resultLable)
        
        NSLayoutConstraint.activate([
            input.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            input.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            input.widthAnchor.constraint(equalToConstant: 200),
            input.heightAnchor.constraint(equalToConstant: 60),
            
            confrimButton.topAnchor.constraint(equalTo: input.bottomAnchor, constant: 50),
            confrimButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            confrimButton.widthAnchor.constraint(equalToConstant: 120),
            confrimButton.heightAnchor.constraint(equalToConstant: 40),
            
            resultLable.topAnchor.constraint(equalTo: confrimButton.bottomAnchor, constant: 50),
            resultLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            //            resultLable.widthAnchor.constraint(equalToConstant: 200),
            resultLable.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    @objc
    func sendOurURL(){
        if let inputURL = input.text {
            viewModel.shortenURL(input: inputURL)
        }
    }
    
    func changeURL(){
        viewModel.shortenURL(input: "http://google.com/")
    }
    
    func didLoadData() {
        DispatchQueue.main.async {
            self.resultLable.text = self.viewModel.shorenURL
        }
    }
}
