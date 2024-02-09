import UIKit

class FeedViewController: UIViewController {
    
//    private lazy var actionButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .systemBlue
//        button.layer.cornerRadius = 12
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Переход на пост", for: .normal)
//        button.setTitleColor(.systemOrange, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
//        
//        return button
//    }()
    
    var post = Post(title: "Мои новости")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
    }
    
//    @objc func buttonPressed(_ sender: UIButton) {
//        
//        let postViewController = PostViewController()
//        
//        self.navigationController?.pushViewController(postViewController, animated: true)
//        postViewController.titlePost = post.title
//        self.navigationItem.title = postViewController.titlePost
//    }
}
