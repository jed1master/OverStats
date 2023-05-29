//
//  PlayerModel.swift
//  OverStats
//
//  Created by Александр Корепанов on 10.04.2023.
//
import UIKit
import Foundation
import SVGKit


struct PlayerModel {
    let playerName: String
    let privateProfile: Bool
    let playerIconString: String
    let playerEndoresementIconString: String
    var playerIcon: UIImage?
    var playerEndorsementIcon: SVGKImage?
    var ratings: [Ratings]?
    var playerRatings: [PlayerRatings]?
}

struct PlayerRatings {
    let role: String
    var rankIconImage: UIImage?
}

