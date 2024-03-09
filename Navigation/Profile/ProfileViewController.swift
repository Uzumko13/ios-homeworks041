import UIKit

class ProfileViewController: UIViewController {
    
    private let headerId = "header"
    private let postId = "post"
    
    private lazy var postTableView: UITableView = {
        let table = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        addSubview()
        
        setupConstraints()
        tuneTableView()
    }
    
    private func addSubview() {
        view.addSubview(postTableView)
    }
    
    private func tuneTableView() {
        postTableView.rowHeight = UITableView.automaticDimension
        
        let headerView = ProfileHeaderView(frame: view.frame)
        postTableView.setAndLayout(headerView: headerView)
        postTableView.tableFooterView = UIView()
        
        postTableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: postId)
        
        postTableView.register(
            ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: headerId)
        
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.refreshControl = UIRefreshControl()
        postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
    }
    
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    @objc func reloadTableView() {
        postTableView.reloadData()
        postTableView.refreshControl?.endRefreshing()
    }
}



extension ProfileViewController: UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return postExamples.count
        default:
            assertionFailure("no registered section")
            return postExamples.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    private func tableView(_ tableView: UITableView, heighForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = postTableView.dequeueReusableHeaderFooterView(
            withIdentifier: headerId
        ) as? ProfileHeaderView else {
            fatalError()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postTableView.dequeueReusableCell(
            withIdentifier: postId,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError()
        }
        cell.configPostArray(post: postExamples[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 240 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if let post = cell as? PostTableViewCell {
            post.incrementPostViewsCounter()
        }
    }

}
