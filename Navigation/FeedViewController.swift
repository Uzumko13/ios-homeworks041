import UIKit

class FeedViewController: UIViewController {
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Переход на пост", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        
        
        return button
    }()
    
    var post = Post(title: "Мои новости")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "Лента"
        view.backgroundColor = .gray
        
        view.addSubview(actionButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            actionButton.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        actionButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        let postViewController = PostViewController()
        
        postViewController.titlePost = post.title
        
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        self.navigationItem.title = postViewController.titlePost
    }
}
