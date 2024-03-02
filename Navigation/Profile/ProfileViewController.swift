import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        view.addSubview(self.profileHeaderView)
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            self.profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            self.profileHeaderView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}
