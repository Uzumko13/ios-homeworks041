//
//  PostService.swift
//  Navigation
//
//  Created by Иван Беляев on 11.07.2024.
//

import Foundation
import StorageService
import UIKit
class PostService {
    func fetchPost(completion: @escaping (Result<Post, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            guard let self else {return}
            completion(.success(Post.make()[0]))
        })
    }
}
