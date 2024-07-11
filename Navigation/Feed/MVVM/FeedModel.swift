//
//  FeedModel.swift
//  Navigation
//
//  Created by Иван Беляев on 30.05.2024.
//

import UIKit

enum SecretWordError: Error {
    case isEmpty
    case incorrect
}

final class FeedModel {
    
    private let secretWord = "Какой-то пароль"
    
    func check(input: String, completion: @escaping (Result<Bool, Error>) -> Void){
        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            guard let self else { return }
            completion(.success(input == secretWord))
        })
       
    }
    
//    let notificationCenter = NotificationCenter.default
//    private let secretWord: String = "Какой-то пароль"
    
//    init() {}
    
//    func check(input: String, completion: @escaping (Result<Bool, Error>) -> Void){
//         DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: { [weak self] in
//             guard let self else { return }
//             completion(.success(input == secretWord))
//         })
//        
//     }
//    
//    func check(word: String, completion: @escaping (Result<String, SecretWordError>) -> Void) {
//        
//        if word == secretWord {
//            completion(.success("Correct!"))
//        } else if word.isEmpty {
//            completion(.failure(.isEmpty))
//        } else {
//            completion(.failure(.incorrect))
//        }
//    }
    

}
