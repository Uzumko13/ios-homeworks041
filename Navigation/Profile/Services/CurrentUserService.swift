
import UIKit

class CurrentUserService: UserService {
    
    let currentUser = User(userLogin: "Uzumaku13", userName: "Nikolay Mladshiy", userStatus: "Let's go!", userAvatar: .dog)

    func authUser(userLogin: String) throws -> User {
        
        if userLogin == currentUser.userLogin {
            return currentUser
        } else {
            throw LoginError.serverError
        }
    }
    
}
