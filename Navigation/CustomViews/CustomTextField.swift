//
//  CustomTextField.swift
//  Navigation
//
//  Created by Иван Беляев on 30.05.2024.
//

import UIKit

final class CustomTextField: UITextField {
    
    var newText: ((String) -> Void)?
    
    init(
        placeholder emptyText: String,
        onText: ((String) -> Void)?
    ) {
        self.newText = onText
        
        super.init(frame: .zero)
        
        placeholder = emptyText
        
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(printedText), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))
    }
    
    @objc private func printedText() {
        guard let text = text, !text.isEmpty else { return }
        newText?(text)
    }
}
