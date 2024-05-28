import UIKit
import iOSIntPackage
//Unexpected input file: /Users/uzumko/Desktop/Home Work Interface App/Navigation/DEBUG

final class ProfileViewController: UIViewController {
    
    private let headerId = "header"
    private let postId = "post"
    private let photosId = "photos"
    
    private let user: User
    
    private let headerView = ProfileHeaderView()
    
    private let facade = ImagePublisherFacade()
    var collection: [UIImage] = []
    
    static var postTableView: UITableView = {
        let table = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    
    
    // MARK: - Init
    
    init(user: User) {
        
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.headerView.avatar.image = user.avatar
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
            ProfileViewController.postTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
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
        let headerView = ProfileHeaderView()
        
        headerView.avatar.image = user.avatar
        headerView.fullNameLabel.text = user.name

        return headerView

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 240 : 0
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if (indexPath.section == 0) {
//            
//            let photoCollectionViewController = PhotosViewController()
//            
//            Storage.photosTabel.forEach {
//                collection.append(UIImage(imageLiteralResourceName: $0.image))
//            }
//            
//            photoCollectionViewController.imagePublisherFacade = facade
//            
//            photoCollectionViewController.imagePublisherFacade?.addImagesWithTimer(time: 1.5, repeat: 30, userImages: collection)
//            
//            navigationController?.pushViewController(photoCollectionViewController, animated: true)
//        } else {
//            return
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.section == 0) {
            
            let photoCollectionViewController = PhotosViewController()
            
            PhotoStorage.photosTabel.forEach {
                collection.append(UIImage(imageLiteralResourceName: $0.image))
            }
            
            photoCollectionViewController.imagePublisherFacade = facade
            
            photoCollectionViewController.imagePublisherFacade?.addImagesWithTimer(time: 0.5, repeat: 20, userImages: collection)
            
            navigationController?.pushViewController(photoCollectionViewController, animated: true)
        } else {
            return
        }
    }
//    {
//        tableView.deselectRow(at: indexPath, animated: true)
//        switch indexPath.section {
//        case 0:
//            
//            let photoCollectionViewController = PhotosViewController()
//            
//            PhotoStorage.photosTabel.forEach {_ in 
//                collection.append(UIImage(imageLiteralResourceName: Photos.shared.examples))
//            }
//            
//            photoCollectionViewController.imagePublisherFacade = facade
//            photoCollectionViewController.imagePublisherFacade?.addImagesWithTimer(time: 0.5, repeat: 30, userImages: collection)
//            navigationController?.pushViewController(PhotosViewController(), animated: true)
//        case 1:
//            guard let cell = tableView.cellForRow(at: indexPath) else { return }
//            if let post = cell as? PostTableViewCell {
//                post.incrementPostViewsCounter()
//            }
//        default:
//            assertionFailure("Нет зарегистрированной секции")
//        }
//    }
}
