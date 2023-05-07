//
//  Models.swift
//  Instagram-Clone
//
//  Created by Akbarshah Jumanazarov on 5/5/23.
//

import Foundation

public enum Gender {
    case male, female, other
}

public struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

public struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum UserPostType {
    case photo, video
}

public struct  UserPost {
    let id: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // video url or full res video
    let caption: String?
    let likeCounts: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
}

public struct PostLike {
    let username: String
    let postID: String
}

public struct CommentLike {
    let username: String
    let commentID: String
}

public struct PostComment {
    let id: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
    
}
