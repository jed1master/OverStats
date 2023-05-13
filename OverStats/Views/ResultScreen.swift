//
//  ResultScreen.swift
//  OverStats
//
//  Created by Александр Корепанов on 06.03.2023.
//

import UIKit
import SVGKit
import SVGKitSwift

class ResultScreen: UIViewController {
    
    
    
    let playerIconImage = UIImageView()
    let playerNameLabel = UILabel()
    var playerEndoresmentIconImage: SVGKFastImageView?
    let playerModel: PlayerModel
    let tankRoleIconImage = UIImageView()
    let damageRoleIconImage = UIImageView()
    let supportRoleIconImage = UIImageView()
    let tankRankIconImage = UIImageView()
    let damageRankIconImage = UIImageView()
    let supportRankIconImage = UIImageView()
    
    init(playerModel: PlayerModel) {
        self.playerModel = playerModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//    let playerModel = PlayerModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupPlayerIconImage()
        setupPlayerNameLabel()
        setupPlayerEndorsementIconImage()
        setupDamageRoleIconImage()
        setupTankRoleIconImage()
        setupSupportRoleIconImage()
        setupTankRankIconImage()
        setupDamageRankIconImage()
        setupSupportRankIconImage()
        
    }

    
 //MARK: - Setup view objects
    
    func setupPlayerIconImage() {
        
        playerIconImage.image = playerModel.playerIcon
        
        playerIconImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(playerIconImage)
        
        NSLayoutConstraint.activate([
            playerIconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerIconImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            playerIconImage.widthAnchor.constraint(equalToConstant: 200),
            playerIconImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupPlayerNameLabel() {
        
        playerNameLabel.text = playerModel.playerName.uppercased()
        playerNameLabel.textAlignment = .center
        playerNameLabel.textColor = .white
        playerNameLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(playerNameLabel)
        
        NSLayoutConstraint.activate([
            
            playerNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            playerNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            playerNameLabel.topAnchor.constraint(equalTo: playerIconImage.bottomAnchor, constant: 30),
            playerNameLabel.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func setupPlayerEndorsementIconImage() {
        
        guard let playerEndoresmentIconImage = SVGKFastImageView(svgkImage: playerModel.playerEndorsementIcon) else { return }
        
        self.playerEndoresmentIconImage = playerEndoresmentIconImage
        
        playerEndoresmentIconImage.translatesAutoresizingMaskIntoConstraints = false
        
        
//        SVGKImageView *skv = [[SVGKImageView alloc] initWithSVGKImage: [SVGKImage imageNamed:@“image.svg”]];
//        [self.view addSubview: skv]
        
        view.addSubview(playerEndoresmentIconImage)
        
        NSLayoutConstraint.activate([
            playerEndoresmentIconImage.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 10),
            playerEndoresmentIconImage.centerXAnchor.constraint(equalTo: playerNameLabel.centerXAnchor),
            playerEndoresmentIconImage.widthAnchor.constraint(equalToConstant: 100),
            playerEndoresmentIconImage.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setupDamageRoleIconImage() {
        
        guard let endorsmentIconImage = playerEndoresmentIconImage else { return }
            
            damageRoleIconImage.image = UIImage(named: "damageIcon.png")
            
            damageRoleIconImage.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(damageRoleIconImage)
            
            NSLayoutConstraint.activate([
                damageRoleIconImage.topAnchor.constraint(equalTo: endorsmentIconImage.bottomAnchor, constant: 15),
                damageRoleIconImage.centerXAnchor.constraint(equalTo: endorsmentIconImage.centerXAnchor),
                damageRoleIconImage.widthAnchor.constraint(equalToConstant: 90),
                damageRoleIconImage.heightAnchor.constraint(equalToConstant: 80)
            ])
        
    }
    
    func setupTankRoleIconImage() {
        
        guard let endorsmentIconImage = playerEndoresmentIconImage else { return }
        
        
        
        tankRoleIconImage.image = UIImage(named: "tankIcon.png")
        
        tankRoleIconImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tankRoleIconImage)
        
        NSLayoutConstraint.activate([
            tankRoleIconImage.topAnchor.constraint(equalTo: endorsmentIconImage.bottomAnchor, constant: 15),
            tankRoleIconImage.trailingAnchor.constraint(equalTo: damageRoleIconImage.leadingAnchor, constant: -40),
            tankRoleIconImage.widthAnchor.constraint(equalToConstant: 90),
            tankRoleIconImage.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupSupportRoleIconImage() {
        
        guard let endorsmentIconImage = playerEndoresmentIconImage else { return }

        
        
        supportRoleIconImage.image = UIImage(named: "supportIcon.png")
        
        supportRoleIconImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(supportRoleIconImage)
        
        NSLayoutConstraint.activate([
            supportRoleIconImage.topAnchor.constraint(equalTo: endorsmentIconImage.bottomAnchor, constant: 15),
            supportRoleIconImage.leadingAnchor.constraint(equalTo: damageRoleIconImage.trailingAnchor, constant: 40),
            supportRoleIconImage.widthAnchor.constraint(equalToConstant: 90),
            supportRoleIconImage.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setupTankRankIconImage() {
        
        tankRankIconImage.image = UIImage(named: "sampleRankIcon.png")
        
        tankRankIconImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tankRankIconImage)
        
        NSLayoutConstraint.activate([
            tankRankIconImage.topAnchor.constraint(equalTo: tankRoleIconImage.bottomAnchor, constant: 20),
            tankRankIconImage.centerXAnchor.constraint(equalTo: tankRoleIconImage.centerXAnchor),
            tankRankIconImage.widthAnchor.constraint(equalToConstant: 75),
            tankRankIconImage.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func setupDamageRankIconImage() {
        
        damageRankIconImage.image = UIImage(named: "sampleRankIcon.png")
        
        damageRankIconImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(damageRankIconImage)
        
        NSLayoutConstraint.activate([
            damageRankIconImage.topAnchor.constraint(equalTo: damageRoleIconImage.bottomAnchor, constant: 20),
            damageRankIconImage.centerXAnchor.constraint(equalTo: damageRoleIconImage.centerXAnchor),
            damageRankIconImage.widthAnchor.constraint(equalToConstant: 75),
            damageRankIconImage.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func setupSupportRankIconImage() {
        
        supportRankIconImage.image = UIImage(named: "sampleRankIcon.png")
        
        supportRankIconImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(supportRankIconImage)
        
        NSLayoutConstraint.activate([
            supportRankIconImage.topAnchor.constraint(equalTo: supportRoleIconImage.bottomAnchor, constant: 20),
            supportRankIconImage.centerXAnchor.constraint(equalTo: supportRoleIconImage.centerXAnchor),
            supportRankIconImage.widthAnchor.constraint(equalToConstant: 75),
            supportRankIconImage.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
//    func updatePlayerInfo() {
//        DispatchQueue.main.async {
//            playerNameLabel.text = playerModel.playerName
//        }
//
//    }
}



