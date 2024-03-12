import UIKit

class ProfileViewController: UIViewController {
    
    private let headerId = "header"
    private let postId = "post"
    private let photosId = "photos"
    
    private lazy var postTableView: UITableView = {
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
        
        postTableView.register(
            ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: headerId)
        
        postTableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: postId)
        
        postTableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: photosId)
        
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

//MARK: Extentions

extension ProfileViewController: UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = postTableView.dequeueReusableCell(
                withIdentifier: photosId,
                for: indexPath) as! PhotosTableViewCell
            return cell
        case 1:
            let cell = postTableView.dequeueReusableCell(
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
