import UIKit

class ProfileViewController: UIViewController {
    
    static let headerIdent = "header"
    
    static var postTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProfileHeaderView.self, forCellReuseIdentifier: headerIdent)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        view.addSubview(Self.postTableView)
        setupConstraint()
        Self.postTableView.dataSource = self
        
        
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            Self.postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            Self.postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            Self.postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            Self.postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

    //MARK: Extention

extension ProfileViewController: UITableViewDelegate {
    
    func 
}
