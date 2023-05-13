//
//  SearchScreen.swift
//  OverStats
//
//  Created by Александр Корепанов on 15.07.2022.
//

import UIKit

class SearchScreen: UIViewController, UITextFieldDelegate {
    
    var controller = DataController()
    
    let searchButton = UIButton()
    let searchTextField = UITextField()
    let logoImageView = UIImageView()
    let activityIndicator = UIActivityIndicatorView()
    var privateProfile: Bool?
    
    
    
//    var resultScreen : ResultScreen?
    
    
    //сделать референс к самому верхнему констрейнту
    var topConstraint : NSLayoutConstraint?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        controller.delegate = self
        
        setupLogoImageView()
        setupSearchTextField()
        setupSearchButton()
        setupActivityIndicator()
        setupKeyboardHiding()
        
        
    }
    // MARK: - Setup view objects
    
    func setupLogoImageView() {
        
        logoImageView.image = UIImage(named: "ow2logo.png")
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        
        let constraint = logoImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 130)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            constraint,
            logoImageView.widthAnchor.constraint(equalToConstant: 400),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        topConstraint = constraint
    }
    
    func setupSearchTextField() {
        searchTextField.text = "jed1master#2662"
        
        searchTextField.layer.borderWidth = 1
        searchTextField.borderStyle = .roundedRect
        searchTextField.placeholder = "Enter your battletag"
        searchTextField.autocapitalizationType = .none
        searchTextField.autocorrectionType = .default
        // clear button
        searchTextField.endEditing(true)
        searchTextField.textAlignment = .center
        searchTextField.font = UIFont.systemFont(ofSize: 24)
        searchTextField.textColor = .white
        searchTextField.backgroundColor = .orange
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            searchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            searchTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func setupSearchButton() {
        
        searchButton.configuration = .filled()
        searchButton.configuration?.baseBackgroundColor = .orange
        searchButton.configuration?.baseForegroundColor = .black
        searchButton.configuration?.title = "Search"
        
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 30),
            searchButton.centerXAnchor.constraint(equalTo: searchTextField.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 150),
            searchButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func setupActivityIndicator() {
        
        activityIndicator.style = .large
        activityIndicator.color = .white
        
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 30),
            activityIndicator.centerXAnchor.constraint(equalTo: searchButton.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 80),
            activityIndicator.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    // UIProgressView даобавить ниже кнопки поиска, сделать скрытым, показывать пока не пришел ответ в делегат
    @objc func searchButtonTapped() {
        
        if let battletag = searchTextField.text {
            controller.fetchPlayerInfo(battletag: battletag)
        }
        searchTextField.text = ""
        
        activityIndicator.startAnimating()
        
//        goToNextScreen()
    }
    
//    func goToNextScreen() {
//        let nextScreen = ResultScreen()
////        resultScreen = nextScreen
//
//        nextScreen.title = "Result Screen"
//        navigationController?.pushViewController(nextScreen, animated: false)
//
//    }
    
    //MARK: - Setup alert action
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Profile is private", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alert, animated: true)
    }
    
    //MARK: - Setup searchTextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //isEmpty bool? error
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
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(searchTextField.frame, from: searchTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        let textFieldFrame = view.convert(searchTextField.frame, from: searchTextField.superview)
        
        if textFieldBottomY > keyboardTopY {
            
            topConstraint?.constant = -90
            view.setNeedsLayout()
            //            let textBoxY = convertedTextFieldFrame.origin.y
            //            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            //            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        //референс к констрейнту
        //        view.frame.origin.y = 0
        topConstraint?.constant = 50
        view.setNeedsLayout()
    }
}


//MARK: - DataControllerDelegate


extension SearchScreen: DataControllerDelegate {
    
    func didUpdatePlayerInfo(_ dataController: DataController, playerInfo: PlayerModel) {
        
        
        DispatchQueue.main.async { [weak self] in
            
            if playerInfo.privateProfile {
                
                self?.showAlert()
            } else {
                let nextScreen = ResultScreen(playerModel: playerInfo)
//                nextScreen.playerNameLabel.text = playerInfo.playerName.uppercased()
//                nextScreen.playerIconImage.image = playerInfo.playerIcon
                
                
//                print(playerInfo.playerEndorsementIcon)
//                print(playerInfo.playerIcon)
                //вью прогресс
                self?.activityIndicator.stopAnimating()
                
                nextScreen.title = "Result Screen"
//                self?.navigationController?.pushViewController(nextScreen, animated: true)
                self?.present(nextScreen, animated: true)
                
            }
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
