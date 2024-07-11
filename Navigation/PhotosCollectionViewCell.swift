
import UIKit
import StorageService

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photo: UIImage? {
        didSet {
            photoImage.image = photo
        }
    }
    
    var photoImage: UIImageView = {
        let photos = UIImageView()
        photos.contentMode = .scaleAspectFit
        photos.backgroundColor = .systemGray4

        return photos
    }()
    
    //MARK: Initial
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    private func setupViews() {
        
        addSubview(photoImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImage.frame = CGRect(
            x: 0,
            y: 0,
            width: self.bounds.width,
            height: self.bounds.height
        )
        
    }
}
