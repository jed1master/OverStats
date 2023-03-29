//
//  SearchScreen.swift
//  OverStats
//
//  Created by Александр Корепанов on 15.07.2022.
//

import UIKit

class SearchScreen: UIViewController, UITextFieldDelegate {
    
    let controller = DataController()
    
    let searchButton = UIButton()
    let searchTextField = UITextField()
    let logoImageView = UIImageView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        
        setupLogoImageView()
        setupSearchTextField()
        setupSearchButton()
        setupKeyboardHiding()
        
        
    }
    // MARK: - Setup view objects
    
    func setupLogoImageView() {
        
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "ow2logo.png")
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 360),
            logoImageView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
    }
    
    func setupSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.layer.borderWidth = 1
        searchTextField.borderStyle = .roundedRect
        searchTextField.placeholder = "Enter your battletag"
        searchTextField.autocapitalizationType = .none
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
        
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 30),
            searchButton.centerXAnchor.constraint(equalTo: searchTextField.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 150),
            searchButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    @objc func searchButtonTapped() {
        controller.decodeData()
    }
    
    //MARK: - Setup searchTextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter your battletag"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
    
    
    //MARK: - Keyboard appearance setup
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension SearchScreen {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        let textFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }
}

