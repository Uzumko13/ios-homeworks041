import UIKit
//Unexpected input file: /Users/uzumko/Desktop/Home Work Interface App/Navigation/DEBUG

final class ProfileViewController: UIViewController {
    
    private let headerId = "header"
    private let postId = "post"
    private let photosId = "photos"
    
    static var postTableView: UITableView = {
        let table = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    // MARK: Metohds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if DEBUG
        view.backgroundColor = .blue
#else
        view.backgroundColor = .lightGray
#endif
        
        addSubview()
        
        setupConstraints()
        tuneTableView()
    }
    
    private func addSubview() {
        view.addSubview(ProfileViewController.postTableView)
    }
    
    private func tuneTableView() {
        ProfileViewController.postTableView.rowHeight = UITableView.automaticDimension
        
        ProfileViewController.postTableView.register(
            ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: headerId)
        
        ProfileViewController.postTableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: postId)
        
        ProfileViewController.postTableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: photosId)
        
        ProfileViewController.postTableView.dataSource = self
        ProfileViewController.postTableView.delegate = self
        ProfileViewController.postTableView.refreshControl = UIRefreshControl()
        ProfileViewController.postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
    }
    
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            ProfileViewController.postTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            ProfileViewController.postTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            ProfileViewController.postTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            ProfileViewController.postTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    @objc func reloadTableView() {
        ProfileViewController.postTableView.reloadData()
        ProfileViewController.postTableView.refreshControl?.endRefreshing()
    }
}

//MARK: Extentions

extension ProfileViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return postExamples.count
        default:
            assertionFailure("Нет зарегистрированной секции")
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = ProfileViewController.postTableView.dequeueReusableCell(
                withIdentifier: photosId,
                for: indexPath) as! PhotosTableViewCell
            return cell
        case 1:
            let cell = ProfileViewController.postTableView.dequeueReusableCell(
                withIdentifier: postId,
                for: indexPath
            ) as! PostTableViewCell
            cell.configPostArray(post: postExamples[indexPath.row])
            return cell
        default:
            assertionFailure("Нет зарегистрированной секции")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! ProfileHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 240 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        case 1:
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            if let post = cell as? PostTableViewCell {
                post.incrementPostViewsCounter()
            }
        default:
            assertionFailure("Нет зарегистрированной секции")
        }
    }
}
