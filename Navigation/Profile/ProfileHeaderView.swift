import UIKit

class ProfileHeaderView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let mainView = UIView(
            frame: CGRect(x: 50,
                          y: 50,
                          width: 300,
                          height: 300
                         )
            )
        
        mainView.backgroundColor = .systemYellow
    }
    
}

