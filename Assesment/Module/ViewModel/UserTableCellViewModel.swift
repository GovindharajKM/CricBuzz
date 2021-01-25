//
//  UserTableCellViewModel.swift
//  Assesment
//
//  Created by Govindharaj Murugan on 10/01/21.
//

import Foundation

class UserTableCellViewModel {
    
    let userName: String?
    let id: Int?
    let imageUrl: String?
    
    init(userName: String, id: Int, imageUrl:String) {
        self.userName = userName
        self.id = id
        self.imageUrl = imageUrl
    }
}
