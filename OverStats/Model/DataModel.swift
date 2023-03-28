//
//  DataModel.swift
//  OverStats
//
//  Created by Александр Корепанов on 25.03.2023.
//

import Foundation

struct PlayerInfo: Decodable {
    let endorsementIcon: String
    let icon: String
    let name: String
    let ratings: [Ratings]
    let `private`: Bool
}

struct Ratings: Decodable {
    let role: String
    let roleIcon: String
    let rankIcon: String
}
