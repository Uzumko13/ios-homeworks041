import UIKit

final class Photos {
    
    static let shared = Photos()
    
    let examples: [UIImage]
    
    private init() {
        examples = (1...20).compactMap { UIImage(named: "\($0)") }.shuffled()
    }
}
