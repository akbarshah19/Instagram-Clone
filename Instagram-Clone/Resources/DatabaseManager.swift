//
//  DatabaseManager.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 4/30/23.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    ///Checks aviability of usernames or emails
    public func canCreateNewUser(with email: String, username: String, completion: @escaping ((Bool) -> Void)) {
        completion(true)
    }
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseEmail()).setValue(["username": username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}
