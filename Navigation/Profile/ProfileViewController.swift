import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
            
        view.addSubview(self.profileHeaderView)
        
        profileHeaderView.frame = view.frame
        
    }
}
