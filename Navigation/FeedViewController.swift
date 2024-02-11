import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        if #available(iOS 15.0, *) {
            createStackView()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 15.0, *)
    
    
    private func createStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32)
        ])
        actionPostButton(title: "Первый пост", color: .systemOrange, to: stackView, selector: #selector(tapButtonPost))
        actionPostButton(title: "Второй пост", color: .systemCyan, to: stackView, selector: #selector(tapButtonPost))
    }
    
    private func actionPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
        let button = UIButton()
        button.backgroundColor = color
        button.layer.cornerRadius = view.layer.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        view.addArrangedSubview(button)
    }
    
    @objc func tapButtonPost() {
        
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
