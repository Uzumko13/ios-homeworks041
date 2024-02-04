import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var imageCat: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Dog")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image
        return image
    }()
    
}

