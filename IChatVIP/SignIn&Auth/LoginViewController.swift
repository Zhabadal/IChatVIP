//
//  LoginViewController.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 26.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Welcome back!", font: .avenir26())
    
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let needAnAccountLabel = UILabel(text: "Need an account?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonDark())
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    let emailTextFieldView = OneLineTextFieldView(labelText: "Email")
    let passwordTextFieldView = OneLineTextFieldView(labelText: "Password")

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        googleButton.customizeGoogleButton()
        setupConstraints()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        AuthService.shared.login(
            email: emailTextFieldView.textField.text!,
            password: passwordTextFieldView.textField.text!)
        { (result) in
            
            switch result {
            case .success(let user):
                self.showAlert(with: "Успешно", message: "Вы авторизованы")
                print("user.email = \(user.email ?? "")")
            case .failure(let error):
                self.showAlert(with: "Ошибка", message: error.localizedDescription)
            }
        }
    }
    
    private func setupConstraints() {
        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleButton)
        
        let stackView = UIStackView(arrangedSubviews: [loginWithView, orLabel, emailTextFieldView, passwordTextFieldView, loginButton], axis: .vertical, spacing: 40)
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton], axis: .horizontal, spacing: 10)
        bottomStackView.alignment = .firstBaseline
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(160)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(100)
            make.left.right.equalToSuperview().inset(40)
        }
        
        view.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(40)
        }
    }

}

// MARK: - SwiftUI

import SwiftUI

struct LoginViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = LoginViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
