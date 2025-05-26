//
//  User+CoreDataProperties.swift
//  MemorizeStudy
//
//  Created by Danila Savitsky on 26.05.25.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var nickName: String?
    @NSManaged public var passsword: String?
    @NSManaged public var email: String?
    @NSManaged public var highscore: Int16

}

extension User : Identifiable {

}
