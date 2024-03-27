

import UIKit

class TestUserService: UserService {
    
    let testUser = User(userLogin: "TEST", userName: "Test User", userStatus: "Test status", userAvatar: #imageLiteral(resourceName: "dog"))
    
    func authUser(userLogin: String) throws -> User {
        
        return testUser
    }
    
}
