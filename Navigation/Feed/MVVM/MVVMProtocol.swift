//
//  MVVMProtocol.swift
//  Navigation
//
//  Created by Иван Беляев on 18.06.2024.
//

import Foundation
import StorageService

protocol FeedViewOutput {
    var state: State { get set }
    var currentState: ((State) -> Void)? { get set }
    func check(input: String)
    func fetchPost()
}

enum State {
    case initial
    case loading
    case loadedCheck(Bool)
    case loadedPost(Post)
    case error
}
