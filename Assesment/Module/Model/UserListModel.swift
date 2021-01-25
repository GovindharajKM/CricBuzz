//
//  UserListModel+CoreDataClass.swift
//  
//
//  Created by Govindharaj Murugan on 07/01/21.
//
//

import Foundation
import CoreData
import AssesmentModels

@objc(UserListModel)
public class UserListModel: NSManagedObject {

    let managedContext = AppDelegate.shared.persistentContainer.viewContext
    
    func insertListOfUsers(_ arrItem : [Item]) {
        
        // Insert New Entry in table
        for item in arrItem {
            if !self.isExist(id: item.id) {
                let itemObj = NSEntityDescription.insertNewObject(forEntityName: "UserListModel", into: self.managedContext)
                self.insertManagedObject(itemObj, item: item)
            }
        }
        do {
            try self.managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    func isExist(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserListModel")
        fetchRequest.predicate = NSPredicate(format: "id = %d",id)

        let res = try! self.managedContext.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    
    private func insertManagedObject(_ itemObj: NSManagedObject, item: Item) {
        
        itemObj.setValue(item.login, forKey: "login")
        itemObj.setValue("\(item.id)", forKey: "id")
        itemObj.setValue(item.avatarURL, forKey: "avatarURL")
        itemObj.setValue(item.followersURL, forKey: "followersURL")
        itemObj.setValue(item.followingURL, forKey: "followingURL")
        itemObj.setValue(item.url, forKey: "url")
    }
    
    func fetchAllUserFromDB() -> [Item] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserListModel")
        var arrFetchedItem = [Item]()
        do {
            let results = try self.managedContext.fetch(fetchRequest)
            
            if let arrItem = results as? [UserListModel] {
                for item in arrItem {
                    arrFetchedItem.append(self.convertFetchedObject(user: item))
                }
            }
            return arrFetchedItem
            
        } catch let error as NSError {
            print("Could not fetch : \(error), \(error.userInfo)")
        }
        return arrFetchedItem
    }
    
    func convertFetchedObject(user: UserListModel) -> Item {
        var userObj = Item()
        userObj.login = user.login ?? ""
        userObj.id = Int(user.id ?? "0") ?? 0
        userObj.avatarURL = user.avatarURL ?? ""
        userObj.followersURL = user.followersURL ?? ""
        userObj.followingURL = user.followingURL ?? ""
        userObj.url = user.url ?? ""
        return userObj
    }
    
    func deleteAllUsers() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserListModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch let error as NSError {
            print("Could not Delete : \(error), \(error.userInfo)")
        }
    }
}

extension UserListModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserListModel> {
        return NSFetchRequest<UserListModel>(entityName: "UserListModel")
    }

    @NSManaged public var login: String?
    @NSManaged public var id: String?
    @NSManaged public var avatarURL: String?
    @NSManaged public var followersURL: String?
    @NSManaged public var followingURL: String?
    @NSManaged public var url: String?

}
