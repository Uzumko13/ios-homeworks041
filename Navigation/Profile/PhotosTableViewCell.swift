//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Иван Беляев on 10.03.2024.
//

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
        
    }
}
