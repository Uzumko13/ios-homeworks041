import UIKit

class ProfileViewController: UIViewController {
    
    static let headerId = "header"
    static let postId = "post"
    
    private lazy var postTableView: UITableView = {
        let table = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        view.addSubview(postTableView)
        
        setupConstraints()
        
    }
    
    private func tuneTableView() {
        postTableView.rowHeight = UITableView.automaticDimension
        
        let headerView = ProfileHeaderView()
        postTableView.register(ProfileHeaderView.self,
                               forHeaderFooterViewReuseIdentifier: ProfileViewController.headerId)
        postTableView.register(PostTableViewCell.self,
                               forCellReuseIdentifier: ProfileViewController.postId)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.postTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            self.postTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            self.postTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            self.postTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}
