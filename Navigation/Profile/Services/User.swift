//
//  User.swift
//  Navigation
//
//  Created by Иван Беляев on 24.03.2024.
//

import UIKit

protocol UserService {
    
    func authUser(userLogin: String) throws -> User
}

class User {
    
    internal let userLogin: String
    internal let userName: String
    internal let userStatus: String
    internal var userAvatar: UIImage
    
    init(userLogin: String,
         userName: String,
         userStatus: String,
         userAvatar: UIImage) {
        
        self.userLogin = userLogin
        self.userName = userName
        self.userStatus = userStatus
        self.userAvatar = userAvatar
    }
}
