import UIKit

public class PostViewController: UIViewController {
    
    public var titlePost = "NewsPost"
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBrown
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Новость",
            style: .plain,
            target: self,
            action: #selector(buttonPressed)
        )
        
    }
    
    @objc func buttonPressed() {
        
        let infoViewController = InfoViewController()
        
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .pageSheet
        
        present(infoViewController, animated: true)
        
    }
}
