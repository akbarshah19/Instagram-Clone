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
    
    ///Checks aviability of usernames or emails
    public func canCreateNewUser(with email: String, username: String, completion: @escaping ((Bool) -> Void)) {
        
    }
}
