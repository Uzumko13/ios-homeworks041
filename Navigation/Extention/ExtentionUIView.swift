//
//  ExtentionUIView.swift
//  Navigation
//
//  Created by Иван Беляев on 01.06.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
