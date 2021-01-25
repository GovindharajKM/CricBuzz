//
//  WebServices.swift
//  Assesment
//
//  Created by Govindharaj Murugan on 06/01/21.
//

import Foundation
import Alamofire

class WebServices {
    
    
    func APIRequest(_ page: Int = 1) {
        
//        AF.request(url, method: .get)
//          .responseJSON { response in
//              if response.data != nil {
//                let user = User()
//                user.decode(jsonData: response.data!)
////                let json = JSON(data: response.data!)
////                let name = json["people"][0]["name"].string
////                if name != nil {
////                  print(name!)
////                }
//              }
//          }
        
        
//        AF.request("https://api.github.com/search/users?q=torvalds&page=\(page)").validate().responseDecodable(of: User.self) { (response) in
//            guard let films = response.value else { return }
//            User().decode(jsonData: response.data!)
//            print(films)
//        }
    }
}

