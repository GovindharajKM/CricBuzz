//
//  ApiService.swift
//  Assesment
//
//  Created by Govindharaj Murugan on 10/01/21.
//

import Foundation
import AssesmentModels


enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

typealias WebServiceCallBack = (_ success : Bool, _ response : Any?, _ error : APIError? ) -> Void

class ApiService {
    
    init() { }
    
    // Fetch all Users ans Search users by keyword
    func fetchAllUsers(_ pageIndex: Int = 0, searchText: String = "", complete: @escaping WebServiceCallBack) {
        guard Reachability.isConnectedToNetwork() else {
            complete(false, nil, .noNetwork)
            return
        }
        var url = "https://api.github.com/search/users?q=type:user&page=\(pageIndex)"
        if searchText != "" {
            url = "https://api.github.com/search/users?q=\(searchText)&page=\(pageIndex)"
        }
        
        self.getAPIResponseFrom(url) { (success, response, error) in
            DispatchQueue.main.async {
                do {
                    let userDetails = try JSONDecoder().decode(UserList.self, from: response! as! Data)
                    complete(true, userDetails, nil)
                } catch {
                    complete(false, nil, .serverOverload)
                }
            }
        }
    }
    
    func getAPIResponseFrom(_ url : String, callback: @escaping WebServiceCallBack) {
        
        let urlString = URL(string: url)
        var request = URLRequest(url: urlString!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print(error ?? "")
                    callback(false,nil, .serverOverload)
                } else {
                    callback(true, data as AnyObject, .none)
                }
            }
        }
        task.resume()
    }
}
