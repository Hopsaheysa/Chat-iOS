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
    
    //need to have reference to Firabase database
    private let database = Database.database().reference()




    
    
    
    public func test() {
        database.child("foo").setValue(["something" : true])
    }
    
    
    
}

// MARK: - Account Mnager

extension DatabaseManager {
    
    ///Check email in MyUsers table
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        database.child("MyUsers").observeSingleEvent(of: .value) { snapshot in
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                let userDict = snap.value as? [String : String] ?? [:]
                if userDict["email"] == email {
                    print("Email is already used")
                    completion(true)
                    return
                }
            }
            print("Email not used.... proceeding")
            completion(false)
        }
    }
    
    
    ///Inserts new user to database
    public func insertOrUpdateUser(with user: ChatAppUser) {
        database.child("MyUsers").child(user.id).setValue([
            "id": user.id,
            "imageURL": user.imageURL,
            "status": user.status,
            "username": user.username,
            "email": user.email
        ])
    }
}



struct ChatAppUser {
    let id: String
    let imageURL: String
    let status: String
    let username: String
    let email: String
}

