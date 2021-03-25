//
//  UIImageView + Extension.swift
//  iChat
//
//  Created by Alexandr Badmaev on 22.10.2020.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
    
    func setupColor(color: UIColor) {
        let templateImage = image?.withRenderingMode(.alwaysTemplate)
        image = templateImage
        tintColor = color
    }
}
