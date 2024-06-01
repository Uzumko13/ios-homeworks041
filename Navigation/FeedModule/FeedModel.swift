//
//  FeedModel.swift
//  Navigation
//
//  Created by Иван Беляев on 30.05.2024.
//

import UIKit

final class FeedModel {
    
    let notificationCenter = NotificationCenter.default
    private let secretWord: String = "Какой-то пароль"
    
    init() {}
    
    func check(word: String) {
        
        var notification = Notification(
            name: NSNotification.Name(rawValue: "Clear notification"),
            object: nil,
            userInfo: nil)
        
        if word == secretWord {
            notification.name = NSNotification.Name(rawValue: "Word is correct")
        } else {
            notification.name = NSNotification.Name(rawValue: "Word is not correct")
        }
        
        notificationCenter.post(notification)
    }
}
