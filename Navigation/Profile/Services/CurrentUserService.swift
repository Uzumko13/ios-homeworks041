
import UIKit

class CurrentUserService: UserService {
    
    var user = User(login: "Uzumaku13", name: "Nikolay Mladshiy", status: "Let's go!", avatar: .dog)

    func getUser(login: String) -> User? {
        
        return login == user.login ? user : nil
    }
    
}

