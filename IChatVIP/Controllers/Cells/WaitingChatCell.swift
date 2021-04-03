//
//  WaitingChatCell.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//

import UIKit
import SDWebImage

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "WaitingChatCell"
    
    let friendImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 4
        clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat = value as? MChat else { return }
        guard let url = URL(string: chat.friendAvatarStringURL) else { return }
        friendImageView.sd_setImage(with: url)
    }
    
    private func setupConstraints() {
        addSubview(friendImageView)
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
