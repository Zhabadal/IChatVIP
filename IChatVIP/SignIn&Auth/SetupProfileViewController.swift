//
//  SetupProfileViewController.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 26.03.2021.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    let fillImageView = AddPhotoView()
    
    let setupProfileLabel = UILabel(text: "Set up profile!", font: .avenir26())
    
    let fullNameTextFieldView = OneLineTextFieldView(labelText: "Full name")
    let aboutMeTextFieldView = OneLineTextFieldView(labelText: "About me")
    let sexLabel = UILabel(text: "Sex")
    
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
    
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonDark())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl], axis: .vertical, spacing: 12)
        
        let stackView = UIStackView(arrangedSubviews: [fullNameTextFieldView, aboutMeTextFieldView, sexStackView, goToChatsButton], axis: .vertical, spacing: 40)
        
        goToChatsButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        view.addSubview(setupProfileLabel)
        setupProfileLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(160)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(fillImageView)
        fillImageView.snp.makeConstraints { make in
            make.top.equalTo(setupProfileLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(fillImageView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(40)
        }
    }
    
}

// MARK: - SwiftUI

import SwiftUI

struct SetupProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = SetupProfileViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
