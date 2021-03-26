//
//  AddPhotoView.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 26.03.2021.
//

import UIKit

class AddPhotoView: UIView {
    
    let circleView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    var photoImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "avatar"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.tintColor = .buttonDark()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        circleView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.center.equalToSuperview()
        }
        
        addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.left.bottom.equalToSuperview()
        }
        
        addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.left.equalTo(circleView.snp.right).offset(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleView.layer.masksToBounds = true
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
