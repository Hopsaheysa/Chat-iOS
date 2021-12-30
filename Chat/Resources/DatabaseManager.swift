//
//  DatabaseManager.swift
//  Chat
//
//  Created by Marek Stransky on 30.12.2021.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func test() {
        database.child("foo").setValue(["something" : true])
    }
    

    
}

// MARK: - Account Mnager

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {

        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
            
        }
    }
    
    ///Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child("MyUsers").setValue([user.id:
                                                [
                                                    "id": user.id,
                                                    "imageURL": user.imageURL,
                                                    "status": user.status,
                                                    "username": user.username
                                                ]
                                           ])
    }
}



struct ChatAppUser {
    let id: String
    let imageURL: String
    let status: String
    let username: String
}

