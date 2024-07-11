//
//  User.swift
//  Navigation
//
//  Created by Иван Беляев on 24.03.2024.
//

import UIKit

protocol UserService {
    var user: User { get set }
    func getUser(login: String) -> User?
}

extension UserService {
    func getUser(login: String) -> User? {
        return login == user.login ? user : nil
    }
}

class User {
    
    let login: String
    let name: String
    let status: String
    var avatar: UIImage
    
    init(login: String,
         name: String,
         status: String,
         avatar: UIImage) {
        
        self.login = login
        self.name = name
        self.status = status
        self.avatar = avatar
    }
}
