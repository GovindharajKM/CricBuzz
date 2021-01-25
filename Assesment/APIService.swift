//
//  APIService.swift
//  Assesment
//
//  Created by Govindharaj Murugan on 10/01/21.
//
import UIKit
import Alamofire

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchAllUsers(_ pageIndex: Int, searchText: String, complete: @escaping ( _ success: Bool, _ movies: UserList, _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
    // Simulate a long waiting for fetching
    
    func fetchAllUsers(_ pageIndex: Int = 0, searchText: String = "", complete: @escaping ( _ success: Bool, _ movies: UserList, _ error: APIError? )->() ) {
        DispatchQueue.global().async {
            let url = "https://api.github.com/search/users?q=\(searchText)&page=\(pageIndex)"
            AF.request(url).validate().responseDecodable(of: UserList.self) { (response) in
                DispatchQueue.main.async {
                    guard let users = response.value else {
                        complete(false, UserList(), .serverOverload)
                        return
                    }
                    UserListModel().insertListOfUsers(users.items)
                    complete(true, users, nil)
                }
            }
        }
    }

}
