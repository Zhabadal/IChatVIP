//
//  LoginVipViewController.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginVipDisplayLogic: class {
    func displayData(viewModel: LoginVip.Model.ViewModel.ViewModelData)
}

class LoginVipViewController: UIViewController, LoginVipDisplayLogic {
    
    // MARK: - External vars
    var interactor: LoginVipBusinessLogic?
    var router: (NSObjectProtocol & LoginVipRoutingLogic & LoginVipDataPassing)?
    
    // MARK: - Internal vars
    private let welcomeLabel = UILabel(text: "Welcome back!", font: .avenir26())
    
    private let loginWithLabel = UILabel(text: "Login with")
    private let orLabel = UILabel(text: "or")
    private let needAnAccountLabel = UILabel(text: "Need an account?")
    
    private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    private let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonDark())
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    private let emailTextFieldView = OneLineTextFieldView(labelText: "Email")
    private let passwordTextFieldView = OneLineTextFieldView(labelText: "Password")
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController        = self
        let interactor            = LoginVipInteractor()
        let presenter             = LoginVipPresenter()
        let router                = LoginVipRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        googleButton.customizeGoogleButton()
        setupConstraints()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        interactor?.makeRequest(
            request: .loginUser(
                email: emailTextFieldView.textField.text,
                password: passwordTextFieldView.textField.text
            )
        )
    }
    
    @objc private func signUpButtonTapped() {
        router?.routeToParent()
    }
    
    // MARK: - LoginVipDisplayLogic
    
    func displayData(viewModel: LoginVip.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case let .displayAlert(title, message):
            router?.showAlert(title: title, message: message)
            
        case .displayMainTabBar:
            router?.routeToMainTabBar()
            
        case .displaySetupProfile:
            router?.routeToSetupProfile()
        }
    }
    
}

extension LoginVipViewController {
    
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
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
        }
    }
    
}
