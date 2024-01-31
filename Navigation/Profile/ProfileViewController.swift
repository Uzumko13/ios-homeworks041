import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let profileHeaderView = ProfileHeaderView()
        
        view.addSubview(profileHeaderView)
        
        profileHeaderView.frame = view.frame
        
    }
}
