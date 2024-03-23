import SnapKit
import UIKit

final class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private var statusText = "Статус..."
    private var avatarOriginPoint = CGPoint()
    
    //MARK: Visual objects
    lazy var returnAvatarButton: UIButton = {
        let returnButton = UIButton()
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        returnButton.alpha = 0
        returnButton.backgroundColor = .clear
        returnButton.contentMode = .scaleToFill
        returnButton.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.black, renderingMode: .automatic), for: .normal)
        returnButton.tintColor = .black

        return returnButton
    }()
    lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.textColor = .black
        statusTextField.backgroundColor = .white
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        statusTextField.leftView = paddingView
        statusTextField.leftViewMode = .always
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.placeholder = "Новый статус..."
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return statusTextField
    }()
    lazy var statusButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "VkColor")
        btn.setTitle("Установить статус", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowRadius = 4
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.7
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
            
        return btn
    }()
    
    var avatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dog")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.borderWidth = 3.0
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 64.0
        image.clipsToBounds = true
        
        return image
    }()
    var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
            
        return label
    }()
    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Fox"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
            
        return label
    }()
    var avatarBackground: UIView = {
        let avatarBackground = UIView(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        avatarBackground.backgroundColor = .darkGray
        avatarBackground.isHidden = true
        avatarBackground.alpha = 0
        return avatarBackground
    }()
    
    //MARK: Initial
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupAddSubview()
        setupGestureAvatar()
        setupConstraintsSnp()

        
        statusTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Код не был реализован")
    }
    
    //MARK: Setup metohd
    
    private func setupAddSubview() {
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(statusButton)
        addSubview(avatarBackground)
        addSubview(avatar)
        addSubview(returnAvatarButton)
    }
    
    private func setupGestureAvatar() {
        // add a tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnAvatar))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(tapGesture)
        
        returnAvatarButton.addTarget(self, action: #selector(returnAvatarToOrigin), for: .touchUpInside)
    }
    
//    private func setupConstraints() {
//        statusLabel.text = statusText
//        NSLayoutConstraint.activate([
//            avatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
//            avatar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            avatar.widthAnchor.constraint(equalToConstant: 128),
//            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor),
//            
//            returnAvatarButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
//            returnAvatarButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            
//            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
//            fullNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 156),
//            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            fullNameLabel.heightAnchor.constraint(equalToConstant: 28),
//            
//            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 16),
//            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
//            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
//            statusLabel.heightAnchor.constraint(equalTo: fullNameLabel.heightAnchor),
//            
//            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
//            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
//            statusTextField.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
//            statusTextField.heightAnchor.constraint(equalToConstant: 40),
//            
//            statusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
//            statusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            statusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            statusButton.heightAnchor.constraint(equalToConstant: 50),
//            
//        ])
//    }
    private func setupConstraintsSnp() {
        statusLabel.text = statusText
        avatar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.width.equalTo(128)
            make.height.equalTo(128)
        }
        returnAvatarButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
        }
        fullNameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(27)
            make.left.equalToSuperview().inset(156)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(28)
        }
        statusLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(fullNameLabel).offset(22)
            make.left.equalTo(fullNameLabel.snp.left)
            make.right.equalTo(fullNameLabel.snp.right)
            make.height.equalTo(fullNameLabel.snp.height)
        }
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.left.equalTo(fullNameLabel.snp.left)
            make.right.equalTo(fullNameLabel.snp.right)
            make.height.equalTo(40)
        }
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    @objc private func statusButtonPressed() {
        statusLabel.text = statusText
    }
    
    @objc private func didTapOnAvatar() {
        avatar.isUserInteractionEnabled = false
        ProfileViewController.postTableView.isScrollEnabled = false
        ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
        
        avatarOriginPoint = avatar.center
        let scale = UIScreen.main.bounds.width / avatar.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.avatar.center = CGPoint(x: UIScreen.main.bounds.midX,
                                                  y: UIScreen.main.bounds.midY - self.avatarOriginPoint.y)
            self.avatar.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.avatar.layer.cornerRadius = 0
            self.avatarBackground.isHidden = false
            self.avatarBackground.alpha = 0.7
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.returnAvatarButton.alpha = 1
            }
        }
    }
    
    @objc private func returnAvatarToOrigin() {
            UIImageView.animate(withDuration: 0.5) {
                UIImageView.animate(withDuration: 0.5) {
                    self.returnAvatarButton.alpha = 0
                    self.avatar.center = self.avatarOriginPoint
                    self.avatar.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.avatar.layer.cornerRadius = self.avatar.frame.width / 2
                    self.avatarBackground.alpha = 0
                }
            } completion: { _ in
                ProfileViewController.postTableView.isScrollEnabled = true
                ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
                self.avatar.isUserInteractionEnabled = true
            }
        }
}

    //MARK: Extention

extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
