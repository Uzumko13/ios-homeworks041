//
//  FeedView.swift
//  Navigation
//
//  Created by Иван Беляев on 23.06.2024.
//

import UIKit

final class FeedView: UIView {
    
    private let viewModel: FeedViewModel
    
    private lazy var secretWordTextField: CustomTextField = {
//        let secretWordTextField = CustomTextField(placeholder: "Место для проверки пароля", onText: self.secretWordTextFieldChanged)
        let secretWordTextField = CustomTextField(placeholder: "Место для проверки пароля", onText: )
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
    
    private lazy var firstButton: CustomButton = {
        let button = CustomButton(titleText: "Показать пост", titleColor: .white, backgroundColor: .blue, tapAction: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
            button.layer.cornerRadius = 10
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints() {
        
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
    
//    private func actionSetStatusButtonPressed() {
//        secretWordTextField.endEditing(true)
//        
//        if secretWordTextField.text != nil && secretWordTextField.text?.count != 0 {
//            print("Password sent to server")
//            viewModel.check(word: secretWordTextField.text!)
//        }
//    }
    
    private func secretWordTextFieldChanged(_: String) {
        print("Some password has been typed")
    }
    
}
