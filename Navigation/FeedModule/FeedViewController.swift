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
        print(type(of: self), #function)
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
        
        removeObservers()
    }
    
    // MARK: FeedModel
    
    var viewModel: FeedModel
    
    private var fullScreenBV: UIView = {
        let fullScreenBV = UIView()
        fullScreenBV.backgroundColor = .black
        fullScreenBV.alpha = 0
        
        fullScreenBV.translatesAutoresizingMaskIntoConstraints = false
        return fullScreenBV
    }()

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
    
    private lazy var checkGuessButton: CustomButton  = {
        let button = CustomButton(titleText: "Проверить", titleColor: .white, backgroundColor: .darkGray, tapAction: self.actionSetStatusButtonPressed)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        
        return button
    }()
    
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
    
    // MARK: Setup
    
    private func setup() {
        
        addObrervers()
        
        view.backgroundColor = .systemGray3
        
        view.addSubviews(
            checkGuessButton,
            secretWordTextField,
            resultLabel
        )
        
        fullScreenBV.frame = .init(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height
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
            resultLabel.heightAnchor.constraint(equalToConstant: 80),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)

        ])
    }
    
    private func actionSetStatusButtonPressed() {
        secretWordTextField.endEditing(true)
        
        if secretWordTextField.text != nil && secretWordTextField.text?.count != 0 {
            print("Password sent to server")
            viewModel.check(word: secretWordTextField.text!)
        }
    }
    
    private func secretWordTextFieldChanged(_: String) {
        print("Some password has been typed")
    }
    
    @objc func trueSelector() {
        print("Password is true")
        
        resultLabel.text = "Ты молодец!"
        resultLabel.textColor = .green
        resultLabel.layer.borderColor = UIColor.green.cgColor
        
        resultAnimation()
    }

    @objc func falseSelector() {
        print("Password is false")
        
        resultLabel.text = "Неправильно! Пробовать снова."
        resultLabel.textColor = .red
        
        resultLabel.layer.borderColor = UIColor.red.cgColor
        
        resultAnimation()
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
    
    // MARK: - Animations
    
    func resultAnimation() {
        
        // Appering animation
        
        let xScaleAppearAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleAppearAnimation.fromValue = 1
        xScaleAppearAnimation.toValue = 2

        let yScaleAppearAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleAppearAnimation.fromValue = 1
        yScaleAppearAnimation.toValue = 2
        
        let resultAppearAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        resultAppearAlphaAnimation.fromValue = 0
        resultAppearAlphaAnimation.toValue = 1
        
        let appearGroupForResult = CAAnimationGroup()
        appearGroupForResult.animations = [xScaleAppearAnimation, yScaleAppearAnimation, resultAppearAlphaAnimation]

        appearGroupForResult.duration = 0.25
        appearGroupForResult.isRemovedOnCompletion = true
        appearGroupForResult.fillMode = .forwards

        resultLabel.layer.add(appearGroupForResult, forKey: "result appear animation")
        
        let backgroundAppearAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAppearAlphaAnimation.fromValue = 0
        backgroundAppearAlphaAnimation.toValue = 0.5
        
        let appearGroupForBackground = CAAnimationGroup()
        appearGroupForBackground.animations = [backgroundAppearAlphaAnimation]
        
        appearGroupForBackground.duration = 0.25
        appearGroupForBackground.isRemovedOnCompletion = true
        appearGroupForBackground.fillMode = .forwards
        
        fullScreenBV.layer.add(appearGroupForBackground, forKey: "background appear animation")
        
        // Static animation
        let xScaleShowAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleShowAnimation.fromValue = 2
        xScaleShowAnimation.toValue = 2

        let yScaleShowAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleShowAnimation.fromValue = 2
        yScaleShowAnimation.toValue = 2
        
        let resultShowAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        resultShowAlphaAnimation.fromValue = 1
        resultShowAlphaAnimation.toValue = 1
        
        let showGroupForResult = CAAnimationGroup()
        showGroupForResult.animations = [xScaleShowAnimation, yScaleShowAnimation, resultShowAlphaAnimation]

        showGroupForResult.beginTime = CACurrentMediaTime() + 0.25
        showGroupForResult.duration = 0.5
        showGroupForResult.isRemovedOnCompletion = true
        showGroupForResult.fillMode = .forwards

        resultLabel.layer.add(showGroupForResult, forKey: "result static animation")
        
        let backgroundShowAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundShowAlphaAnimation.fromValue = 0.5
        backgroundShowAlphaAnimation.toValue = 0.5
        
        let showGroupForBackground = CAAnimationGroup()
        showGroupForBackground.animations = [backgroundShowAlphaAnimation]
        
        showGroupForBackground.beginTime = CACurrentMediaTime() + 0.25
        showGroupForBackground.duration = 0.5
        showGroupForBackground.isRemovedOnCompletion = true
        showGroupForBackground.fillMode = .forwards
        
        fullScreenBV.layer.add(showGroupForBackground, forKey: "background static animation")
    
        // Dissappearing animation
        let xScaleDissappearAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleDissappearAnimation.fromValue = 2
        xScaleDissappearAnimation.toValue = 1

        let yScaleDissappearAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleDissappearAnimation.fromValue = 2
        yScaleDissappearAnimation.toValue = 1
        
        let resultDissappearAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        resultDissappearAlphaAnimation.fromValue = 1
        resultDissappearAlphaAnimation.toValue = 0
        
        let dissappearGroupForResult = CAAnimationGroup()
        dissappearGroupForResult.animations = [xScaleDissappearAnimation, yScaleDissappearAnimation, resultDissappearAlphaAnimation]

        dissappearGroupForResult.beginTime = CACurrentMediaTime() + 0.75
        dissappearGroupForResult.duration = 0.25
        dissappearGroupForResult.isRemovedOnCompletion = true
        dissappearGroupForResult.fillMode = .removed

        resultLabel.layer.add(dissappearGroupForResult, forKey: "result dissappear animation")
        
        let backgroundDissappearAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundDissappearAlphaAnimation.fromValue = 0.5
        backgroundDissappearAlphaAnimation.toValue = 0
        
        let dissappearGroupForBackground = CAAnimationGroup()
        dissappearGroupForBackground.animations = [backgroundDissappearAlphaAnimation]
        
        dissappearGroupForBackground.beginTime = CACurrentMediaTime() + 0.75
        dissappearGroupForBackground.duration = 0.25
        dissappearGroupForBackground.isRemovedOnCompletion = true
        dissappearGroupForBackground.fillMode = .forwards
        
        fullScreenBV.layer.add(dissappearGroupForBackground, forKey: "background dissappear animation")
    }
}

