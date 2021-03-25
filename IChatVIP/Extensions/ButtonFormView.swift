//
//  ButtonFormView.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 25.03.2021.
//

import UIKit
import SnapKit

class ButtonFormView: UIView {
    
    init(label: UILabel, button: UIButton) {
        super.init(frame: .zero)
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
        }
        
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
