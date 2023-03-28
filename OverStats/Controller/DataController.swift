//
//  DataController.swift
//  OverStats
//
//  Created by Александр Корепанов on 25.03.2023.
//

import Foundation

class DataController: Decodable {
    
    func decodeData() {
        
        let urlString = "https://ow-api.com/v1/stats/pc/ru/jed1master-2662/profile"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let playerInfo = try decoder.decode(PlayerInfo.self, from: safeData)
//                        DispatchQueue.main.async {
//                            <#code#>
//                        }
                        print(playerInfo)
                    } catch {
                        print(error)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
//    func getImage(imageUrl: тип из структуры?? как?) {
//
//        let urlString = ""
//
//         if let url = URL(string: urlString) {
//
//             let session = URLSession.shared
//
//             let dataTask = session.dataTask(with: url) { data, response, error in
//
//                 if error != nil {
//                     print(error!)
//                     return
//                 }
//                 if let safeData = data {
//                     let decoder = JSONDecoder()
//                     do {
//                         //картинок несколько, новая структура??
//                         UIImage(data: safeData)
//                     } catch {
//                         print(error)
//                     }
//                 }
//             }
//             dataTask.resume()
//         }
//     }
    
    
}
