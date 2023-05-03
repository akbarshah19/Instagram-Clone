//
//  StorageManager.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 4/30/23.
//

import Foundation
import FirebaseStorage

public enum UserPostType {
    case photo, video
}

public struct  UserPost {
    let postType: UserPostType
}

public enum StorageManagerError: Error {
    case failedToDownload
}

public class StorageManager {
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public func uploadUserPhotoPost(model: UserPost, completion: @escaping (Result<URL,Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, StorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        }
    }
}
