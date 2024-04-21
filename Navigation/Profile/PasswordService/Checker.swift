//
//  Checker.swift
//  Navigation
//
//  Created by Иван Беляев on 18.04.2024.
//

import Foundation


class Checker {
    
    static let shared = Checker()
    
    private let login: String = "Uzumko"
    private let password: String = "NmDh2Sp"
    
    private init() {
        
    }
    
    func check (loginPassword trierString: String) -> Bool {
        trierString == login + password
    }
}
