//
//  UILabel + Extension.swift
//  iChat
//
//  Created by Alexandr Badmaev on 22.10.2020.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
    
}
