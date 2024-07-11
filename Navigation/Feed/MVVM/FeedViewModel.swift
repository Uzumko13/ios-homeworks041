//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Иван Беляев on 20.06.2024.
//

import UIKit

final class FeedViewModel: FeedViewOutput {
    
    private let feedModel: FeedModel
    
    private let postService: PostService
    
    var state: State = .initial {
        didSet {
            print(state)
            currentState?(state)
        }
    }
    
    init(feedModel: FeedModel, postService: PostService) {
        self.feedModel = feedModel
        self.postService = postService
    }
    
    var currentState: ((State) -> Void)?
    
    func fetchPost() {
        state = .loading
        postService.fetchPost { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let post):
                    state = .loadedPost(post)
                case .failure(_):
                    state = .error
            }
        }
    }
    
    func check(input: String) {
            state = .loading
            feedModel.check(input: input) { [weak self] result in
                guard let self else { return }
                switch result {
                    case .success(let isSuccess):
                        state = .loadedCheck(isSuccess)
                    case .failure(_):
                        state = .error
                }
            }
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
