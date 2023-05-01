//
//  AuthManager.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 4/30/23.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard authResult != nil, error == nil else {
                        print("Could not create account.")
                        completion(false)
                        return
                    }
                    
                    
                    
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    print("Could not sign in.")
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            print(username)
        }
    }
}
