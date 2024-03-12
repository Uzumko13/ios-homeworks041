import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    //MARK: Visual objects
    
    var labelPhotos: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Фото"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    var arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        return arrow
    }()
    
    var imageStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        
        return stack
    }()
    
    func getPreviewImage(index: Int) -> UIImageView {
        let preview = UIImageView()
        preview.translatesAutoresizingMaskIntoConstraints = false
        preview.image = Photos.shared.examples[index]
        preview.contentMode = .scaleAspectFill
        preview.layer.cornerRadius = 6
        preview.clipsToBounds = true
        
        return preview
    }
    
    //MARK: Initial section
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAddSubview()
        setupPreviews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Код не был реализован")
    }
    
    // MARK: setup metohd
    
    private func setupAddSubview() {
        contentView.addSubview(labelPhotos)
        contentView.addSubview(arrow)
        contentView.addSubview(imageStackView)
    }
    
    private func setupPreviews() {
        for index in 0...3 {
            let image = getPreviewImage(index: index)
            imageStackView.addArrangedSubview(image)
            NSLayoutConstraint.activate([
                image.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 24) / 4),
                image.heightAnchor.constraint(equalTo: image.widthAnchor)
            ])
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelPhotos.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indentTwelve),
            labelPhotos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentTwelve),
            labelPhotos.widthAnchor.constraint(equalToConstant: 80),
            labelPhotos.heightAnchor.constraint(equalToConstant: 24),
            
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.indentTwelveMinus),
            arrow.centerYAnchor.constraint(equalTo: labelPhotos.centerYAnchor),
            arrow.heightAnchor.constraint(equalToConstant: 24),
            arrow.widthAnchor.constraint(equalToConstant: 24),

            imageStackView.topAnchor.constraint(equalTo: labelPhotos.bottomAnchor, constant: LayoutConstants.indentTwelve),
            imageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentTwelve),
            imageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.indentTwelveMinus),
            imageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutConstants.indentTwelveMinus),
        ])
    }
}
