//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Иван Беляев on 20.06.2024.
//

import UIKit

final class FeedViewModel: FeedViewOutput {
    
    
    var state: State
    
    var currentState: ((State) -> Void)?
    
    func check(input: String) {
        <#code#>
    }
    
    func fetchPost() {
        <#code#>
    }
    
    
    private let feedModel: FeedModel
    
    init(model: FeedModel) {
        self.feedModel = model
    }
    
//    func validateSecretWord(word: String, completion: @escaping (String) -> Void) {
//        var message: String = ""
//        
//        feedModel.check(word: word) { 
//            result in
//            switch result {
//            case .success(let successMessage):
//                message = successMessage
//            case .failure(let error):
//                switch error {
//                case .isEmpty:
//                    message = "Please enter the secret word"
//                case .incorrect:
//                    message = "Incorrect!"
//                }
//            }
//        }
//        completion(message)
//    }
    
    func buttonTapped() {
        
    }
    
}
