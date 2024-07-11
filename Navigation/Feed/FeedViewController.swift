import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    private var viewModel: FeedViewOutput
    
    init(viewModel: FeedViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var buttonOne: CustomButton = {
        let button = CustomButton(titleText: "Открыть пост", titleColor: .white, backgroundColor: .blue){
            self.viewModel.fetchPost()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var secretWordTextField: UITextField = {
        let secretWordTextField = UITextField()
        secretWordTextField.font = UIFont.systemFont(ofSize: 16)
        secretWordTextField.leftView = UIView(frame:
                                                CGRect(
                                                    x: 0,
                                                    y: 0,
                                                    width: 14,
                                                    height: 80
                                                )
        )
        secretWordTextField.layer.cornerRadius = 12
        secretWordTextField.backgroundColor = .white
        secretWordTextField.layer.borderWidth = 1
        secretWordTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        return secretWordTextField
    }()
    
    private var checkGuessButton: CustomButton  {
        let button = CustomButton(titleText: "Проверить", titleColor: .white, backgroundColor: .darkGray){
            if(self.secretWordTextField.text != nil){
                self.viewModel.check(input: self.secretWordTextField.text!)
            }
        }
            button.layer.cornerRadius = 6
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.masksToBounds = true
            
            return button
        }
        
    private lazy var checkGuessLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.addArrangedSubview(self.buttonOne)
        stackView.addArrangedSubview(self.secretWordTextField)
        stackView.addArrangedSubview(self.checkGuessButton)
        stackView.addArrangedSubview(self.checkGuessLabel)
        
        return stackView
    }()
        
        //MARK: SelfLoop
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .lightGray
            view.addSubview(stackView)
            view.addSubview(activityIndicator)
            setup()
            bindViewModel()
        }
        
        //     MARK: Setup
        
    private func bindViewModel() {
        viewModel.currentState = { [weak self] state in
            guard let self else { return }
            
            switch state {
            case .initial:
                print("initial")
            case .loading:
                activityIndicator.isHidden = false
                stackView.isHidden = true
                activityIndicator.startAnimating()
            case .loadedPost(let post):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    activityIndicator.isHidden = true
                    activityIndicator.stopAnimating()
                    stackView.isHidden = false
                    routeToPostViewController(post: post)
                }
            case .error:
                print("error")
            case .loadedCheck(let isSuccess):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    activityIndicator.isHidden = true
                    activityIndicator.stopAnimating()
                    stackView.isHidden = false
                    if (isSuccess) {
                        self.checkGuessLabel.textColor = .green
                        self.checkGuessLabel.text = "success"
                    } else {
                        self.checkGuessLabel.textColor = .red
                        self.checkGuessLabel.text = "failed"
                    }
                }
            }
        }
    }
    
    private func setup() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
                
                activityIndicator.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor)
            ])
    }
    
    func routeToPostViewController(post: Post) {
        let postViewController = PostViewController()
        
        postViewController.titlePost = post.author
        
        self.navigationController?.pushViewController(postViewController, animated: true)
        
    }
        
}

