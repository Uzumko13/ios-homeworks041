//
//  CustomButton.swift
//  Navigation
//
//  Created by Иван Беляев on 28.05.2024.
//

import UIKit

final class CustomButton: UIButton {
    
    var nextAction: (() -> Void)?
    
    init(
        titleText title: String,
        titleColor color: UIColor,
        backgroundColor bgColor: UIColor,
        tapAction: (() -> Void)?
    ) {
        self.nextAction = tapAction
        
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        backgroundColor = bgColor
        
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        nextAction?()
    }
}
