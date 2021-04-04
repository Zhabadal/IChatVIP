//
//  UIScrollView+Extension.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 04.04.2021.
//

import UIKit

extension UIScrollView {
    
    var isAtBottom: Bool {
        contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}
