import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText = "Готов помочь"
    
    //MARK: Visual objects
    
    var avatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Dog")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 3.0
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 64.0
        image.clipsToBounds = true
        
        return image
    }()
        
    var statusButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .blue
        btn.setTitle("Show status", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 4
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.7
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(ProfileHeaderView.self, action: #selector(statusButtonPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
            
        return btn
    }()
        
    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Dog Name"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
            
        return label
    }()
        
    var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
            
        return label
    }()
    
        
    var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.backgroundColor = .white
        
        
        return statusTextField
    }()
    
    //MARK: Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAvatarConstraint()
        setupNameLabelConstraint()
        setupStatusLabel()
        setupStatusTextFieldConstraint()
        setupStatusButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("LoL")
    }
    
    private func setupNameLabelConstraint() {
        addSubview(fullNameLabel)
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 156),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func setupAvatarConstraint() {
        addSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatar.widthAnchor.constraint(equalToConstant: 128),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor)
        ])
    }
    
    private func setupStatusLabel() {
        statusLabel.text = statusText
        addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            statusLabel.heightAnchor.constraint(equalTo: fullNameLabel.heightAnchor)
        ])
    }
    
    private func setupStatusTextFieldConstraint() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        statusTextField.leftView = paddingView
        statusTextField.leftViewMode = .always
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.attributedPlaceholder = NSAttributedString.init(string: "Готово...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        addSubview(statusTextField)
        NSLayoutConstraint.activate([
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupStatusButton() {
        addSubview(statusButton)
        NSLayoutConstraint.activate([
            statusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            statusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    @objc private func statusButtonPressed() {
        statusLabel.text = statusText
    }
}


extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
