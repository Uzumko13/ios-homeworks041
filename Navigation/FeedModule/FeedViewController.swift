import UIKit
import StorageService

class FeedViewController: UIViewController {
    
//    var post = Post(title: "Мои новости")
    
    init(viewModel: FeedModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    
    private func setup() {
        
        addObrervers()
        view.backgroundColor = .systemGray3
        
        view.addSubviews(
            checkGuessButton,
            secretWordTextField,
            resultLabel
        )
        
        NSLayoutConstraint.activate([
            
            checkGuessButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkGuessButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -50),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 100),
            
            secretWordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secretWordTextField.centerYAnchor.constraint(equalTo: checkGuessButton.topAnchor, constant: -40),
            secretWordTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            secretWordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            resultLabel.centerXAnchor.constraint(equalTo: secretWordTextField.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: secretWordTextField.centerYAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 50),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)

        ])

        
    }
    // MARK: FeedModel
    
    var viewModel: FeedModel
    
    // Textfield for word to be checked
    private lazy var secretWordTextField: CustomTextField = {
        let secretWordTextField = CustomTextField(placeholder: "Место для проверки пароля", onText: self.secretWordTextFieldChanged)
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
    
    // Button for checking word
    private lazy var checkGuessButton: CustomButton  = {
        let button = CustomButton(titleText: "Check", titleColor: .white, backgroundColor: .gray, tapAction: self.actionSetStatusButtonPressed)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        
        return button
    }()
    
    // Result label
    private var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.font = UIFont.boldSystemFont(ofSize: 10)
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .black
        resultLabel.backgroundColor = .systemGray3
        resultLabel.textAlignment = .center
        resultLabel.alpha = 0
        
        resultLabel.layer.cornerRadius = 20
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.black.cgColor
        resultLabel.layer.masksToBounds = true
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    private func actionSetStatusButtonPressed() {
        secretWordTextField.endEditing(true)
    }
    
    private func secretWordTextFieldChanged(_: String) {
        print("Some password has been typed")
    }
    
    @objc func tapButtonPost() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc func trueSelector() {
        print("Password is true")
        
        resultLabel.text = "You've done well!"
        resultLabel.textColor = .green
        resultLabel.layer.borderColor = UIColor.green.cgColor
    }

    @objc func falseSelector() {
        print("Password is false")
        
        resultLabel.text = "Wrong! Try again."
        resultLabel.textColor = .red
        
        resultLabel.layer.borderColor = UIColor.red.cgColor
        
//        resultAnimation()
    }
    
    // MARK: Observers
    // Add
    
    func addObrervers() {
        NotificationCenter.default.addObserver(self, selector: #selector(trueSelector), name: NSNotification.Name(rawValue: "Word is correct") , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(falseSelector), name: NSNotification.Name(rawValue: "Word is not correct") , object: nil)
    
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Word is correct"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Word is not correct"), object: nil)
    }
}
