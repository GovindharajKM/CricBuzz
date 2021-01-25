//
//  HomeViewModel.swift
//  Assesment
//
//  Created by Govindharaj Murugan on 10/01/21.
//

import Foundation
import UIKit
import AssesmentModels

class HomeViewModel {
    
    var apiService: ApiService = { return ApiService()}()
    lazy var searchBar: UISearchBar = UISearchBar()
    lazy var pageIndex = 0
    lazy var rowHeight: CGFloat = 70
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var showAlertClosure: (()->())?
    
    private var user = UserList()
    
    var searchBarTextField : UITextField! {
        if #available(iOS 13.0, *) {
            return self.searchBar.searchTextField
        } else {
            if let searchField = self.searchBar.value(forKey: "searchField") as? UITextField {
                return searchField
            }
            return UITextField()
        }
    }
    
    private var arrUsers:[Item] = [Item]() {
        didSet {
            var arrViewModel = [UserTableCellViewModel]()
            for user in arrUsers {
                arrViewModel.append(self.createCellViewModel(item:user))
            }
            self.arrUserCellModel = arrViewModel
        }
    }
    
    private var arrUserCellModel: [UserTableCellViewModel] = [UserTableCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    var storedDataSource : [Item] {
        return UserListModel().fetchAllUserFromDB()
    }

    var numberOfCells: Int {
        return arrUsers.count
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath ) -> UserTableCellViewModel {
        return arrUserCellModel[indexPath.row]
    }
    
    func getDataSource(at indexpath: IndexPath) -> Item {
        return self.arrUsers[indexpath.row]
    }
    
    func getSearchBar() {
        self.searchBar.searchBarStyle = .prominent
        self.searchBar.placeholder = " Search..."
        self.searchBar.sizeToFit()
        self.searchBar.isTranslucent = false
        self.searchBar.returnKeyType = .done
        self.searchBar.backgroundImage = UIImage()
    }
    
    // MARK:-  API request
    func initFetch() {
        if self.pageIndex == 0 || self.user.totalCount > self.arrUsers.count {
            self.pageIndex += 1
        } else if self.user.totalCount == self.arrUsers.count {
            return
        }
        self.isLoading = true
        
        self.apiService.fetchAllUsers(self.pageIndex, searchText: self.searchBarTextField.text ?? "") { [weak self] (success, userList, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.rawValue
            } else {
                self?.processFetchedUsers(userList as! UserList)
            }
        }
    }
    
    private func processFetchedUsers(_ userList: UserList) {
        self.user = userList
        UserListModel().insertListOfUsers(userList.items)
        self.validateSearchConditions()
    }
    
    func createCellViewModel(item: Item ) -> UserTableCellViewModel {
        return UserTableCellViewModel(userName: item.login, id: item.id, imageUrl: item.avatarURL)
    }
    
}


// MARK:- Search Functionalities
extension HomeViewModel {
    
    func searchTextDidChange(_ text: String) {
        
        if Reachability.isConnectedToNetwork() {
            if self.searchBarTextField.text == ""  {
                self.arrUsers = self.storedDataSource
            } else {
                self.initFetch()
            }
        } else {
            self.validateSearchConditions()
        }
    }
    
    func validateSearchConditions() {
        if self.searchBarTextField.text == "" {
            self.arrUsers = self.storedDataSource
        } else {
            let foundArray = self.storedDataSource.filter({ String(describing:$0.login).lowercased() .contains(self.searchBarTextField.text!.lowercased())})
            self.arrUsers = foundArray
        }
    }
    
}
