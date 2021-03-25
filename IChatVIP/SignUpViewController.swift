//
//  SignUpViewController.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 26.03.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Good to see you!", font: .avenir26())
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    let emailTextFieldView = OneLineTextFieldView(labelText: "Email")
    let passwordTextFieldView = OneLineTextFieldView(labelText: "Password")
    let confirmPasswordTextFieldView = OneLineTextFieldView(labelText: "Confirm password")
    
    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonDark())
    let loginButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.buttonRed(), for: .normal)
        loginButton.titleLabel?.font = .avenir20()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, confirmPasswordTextFieldView, signUpButton], axis: .vertical, spacing: 40)
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton], axis: .horizontal, spacing: -1)
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(160)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(160)
            make.left.right.equalToSuperview().inset(40)
        }
        
        view.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(160)
            make.left.right.equalToSuperview().inset(40)
        }
    }

}

// MARK: - SwiftUI

import SwiftUI

struct SignUpViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let signUpViewController = SignUpViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return signUpViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
