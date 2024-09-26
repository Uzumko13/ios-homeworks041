
import UIKit

class TestUserService: UserService {
    
    var user = User(login: "TEST", name: "Test User", status: "Test status", avatar: #imageLiteral(resourceName: "dog"))
    
    func getUser(login: String) -> User? {
        
        return login == user.login ? user : nil
    }
    
}
