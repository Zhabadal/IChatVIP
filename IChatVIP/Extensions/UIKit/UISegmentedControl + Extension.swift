//
//  UISegmentedControl + Extension.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 27.03.2021.
//

import UIKit

extension UISegmentedControl {
    
    convenience init(first: String, second: String) {
        self.init()
        insertSegment(withTitle: first, at: 0, animated: true)
        insertSegment(withTitle: second, at: 1, animated: true)
        selectedSegmentIndex = 0
    }
    
}
