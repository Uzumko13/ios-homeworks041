import UIKit

final class Photos {
    
    static let shared = Photos()
    
    let examples: [UIImage]
    
    private init() {
        examples = (1...20).compactMap { UIImage(named: "\($0)") }.shuffled()
    }
}

public struct Photo {
    public let image: String
}

public struct PhotoStorage {
    
    public static let photosTabel = [
        Photo(
            image: "1"
        ),
        Photo(
            image: "2"
        ),
        Photo(
            image: "3"
        ),
        Photo(
            image: "4"
        ),
        Photo(
            image: "5"
        ),
        Photo(
            image: "6"
        ),
        Photo(
            image: "7"
        ),
        Photo(
            image: "8"
        ),
        Photo(
            image: "9"
        ),
        Photo(
            image: "10"
        ),
        Photo(
            image: "11"
        ),
        Photo(
            image: "12"
        ),
        Photo(
            image: "13"
        ),
        Photo(
            image: "14"
        ),
        Photo(
            image: "15"
        ),
        Photo(
            image: "16"
        ),
        Photo(
            image: "17"
        ),
        Photo(
            image: "18"
        ),
        Photo(
            image: "19"
        ),
        Photo(
            image: "20"
        )
    ]
}
