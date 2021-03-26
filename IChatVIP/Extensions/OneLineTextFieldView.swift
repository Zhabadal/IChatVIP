//
//  OneLineTextField.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 26.03.2021.
//

import UIKit

class OneLineTextFieldView: UIView {
    
    var textField: UITextField!
    
    init(labelText: String, font: UIFont? = .avenir20()) {
        super.init(frame: .zero)
        
        let label = UILabel(text: labelText)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
        }
        
        textField = UITextField()
        textField.font = font
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = .textFieldLight()
        addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
