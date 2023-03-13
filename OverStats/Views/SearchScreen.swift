//
//  SearchScreen.swift
//  OverStats
//
//  Created by Александр Корепанов on 15.07.2022.
//

import UIKit

class SearchScreen: UIViewController {
    
    let searchButton = UIButton()
    let searchTextField = UITextField()
    let logoImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogoImageView()
        setupSearchTextField()
        setupSearchButton()
        
    }
    
    func setupLogoImageView() {
        
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "ow2logo.png")
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 350),
            logoImageView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
    }
    
    func setupSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.layer.borderWidth = 1
        searchTextField.borderStyle = .roundedRect
        searchTextField.placeholder = "Enter your battletag"
        searchTextField.textAlignment = .center
        searchTextField.font = UIFont.systemFont(ofSize: 24)
        searchTextField.textColor = .white
        searchTextField.backgroundColor = .orange
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            searchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            searchTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func setupSearchButton() {
        view.addSubview(searchButton)
        searchButton.configuration = .filled()
        searchButton.configuration?.baseBackgroundColor = .orange
        searchButton.configuration?.baseForegroundColor = .black
        searchButton.configuration?.title = "Search"
        
        
        //            searchButton.addTarget(self, action: #selector(goToNextScreen), for: .touchUpInside)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 30),
            searchButton.centerXAnchor.constraint(equalTo: searchTextField.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 150),
            searchButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
//    @objc func goToNextScreen() {
//        let nextScreen = ResultScreen()
//        nextScreen.title = "Search Result"
//        navigationController?.pushViewController(nextScreen, animated: true)
//    }
}

