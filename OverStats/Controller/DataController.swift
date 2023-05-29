//
//  DataController.swift
//  OverStats
//
//  Created by Александр Корепанов on 25.03.2023.
//

import Foundation
import UIKit
import SVGKit
import SVGKitSwift

protocol DataControllerDelegate {
    func didUpdatePlayerInfo(_ dataController: DataController, playerInfo: PlayerModel)
    func didFailWithError(error: Error)
}

class DataController {
    var playerNameP : String = ""
    var playerIconImage : UIImage?
    var playerEndorsementIconImage : UIImage?
    var tankRoleIconImage : UIImage?
    var damageRoleIconImage : UIImage?
    var supportRoleIconImage : UIImage?
    var tankRankIconImage : UIImage?
    var damageRankIconImage : UIImage?
    var supportRankIconImage : UIImage?
    
    var delegate: DataControllerDelegate?
    
    
    func fetchPlayerInfo(battletag: String) {
        
        let urlString = "https://ow-api.com/v1/stats/pc/ru/\(battletag.replacingOccurrences(of: "#", with: "-"))/profile"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] data, response, error in
                if error != nil {
                    self?.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if var playerInfo = self?.parseJSON(safeData),
                       let controller = self,
                       let rating = playerInfo.ratings
                    {
                        
                        
                        self?.getImage(url: playerInfo.playerIconString, completion: { playerIcon in
                            
                            self?.getSVGImage(url: playerInfo.playerEndoresementIconString, completion: { playerEndorsementIcon in
                                
                                self?.getRatringsImages(dataRating: rating, completion: { playerRatings in
                                    
                                    playerInfo.playerRatings = playerRatings
                                    playerInfo.playerIcon = playerIcon
                                    playerInfo.playerEndorsementIcon = playerEndorsementIcon
                                    controller.delegate?.didUpdatePlayerInfo(controller, playerInfo: playerInfo)
                                })
                                
                                
                                
                                
                            })
                        })
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ playerData: Data) -> PlayerModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PlayerData.self, from: playerData)
            let name = decodedData.name
            let priv = decodedData.`private`
            let playerIcon = decodedData.icon
            let endorsementIcon = decodedData.endorsementIcon
            let ratings = decodedData.ratings
            
            
            //функция для рейта массив потом тока в плеер модель
            
            let playerInfo = PlayerModel(playerName: name, privateProfile: priv, playerIconString: playerIcon, playerEndoresementIconString: endorsementIcon, ratings: ratings, playerRatings: [])
            return playerInfo
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    func getImage(url: String, completion: @escaping (UIImage) -> ()) {
        
        print(url)
        
        if let url = URL(string: url) {
            
            let dataTask = URLSession.shared.dataTask(with: url) {  data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data, let image = UIImage(data: safeData) {
                    
                    
                    completion(image)
                } else {
                    print("failed", url)
                }
            }
            dataTask.resume()
        }
    }
    
    func getSVGImage(url: String, completion: @escaping (SVGKImage) -> ()) {
        
        print(url)
        
        if let url = URL(string: url) {
            
            let dataTask = URLSession.shared.dataTask(with: url) {  data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data, let image = SVGKImage(data: safeData) {
                    
                    completion(image)
                } else {
                    print("failed", url)
                }
            }
            dataTask.resume()
        }
    }
    
    func getRatringsImages(dataRating: [Ratings], completion: @escaping ([PlayerRatings]) -> ()) {
        
        var elements = dataRating
        
        if elements .isEmpty {
            completion([])
        } else {
            
            let lastElement = elements.removeLast()
            
            guard let lastIconUrl = lastElement.rankIcon, let lastRole = lastElement.role
            else { return }
            
            getImage(url: lastIconUrl ) { rankIconImage in
                
                self.getRatringsImages(dataRating: elements) { playerRatings in
                    
                    var ratingWithRoleAndImage = playerRatings
                    
                    ratingWithRoleAndImage.append(PlayerRatings(role: lastRole, rankIconImage: rankIconImage))
                    completion(ratingWithRoleAndImage)
                }
            }
            
        }
    }
}
