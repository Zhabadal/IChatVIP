//
//  SignUpVipViewController.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SignUpVipDisplayLogic: class {
    func displayData(viewModel: SignUpVip.Model.ViewModel.ViewModelData)
}

class SignUpVipViewController: UIViewController, SignUpVipDisplayLogic {
    
    // MARK: - External vars
    var interactor: SignUpVipBusinessLogic?
    var router: (NSObjectProtocol & SignUpVipRoutingLogic & SignUpVipDataPassing)?
    
    // MARK: - Internal vars
    private let welcomeLabel = UILabel(text: "Good to see you!", font: .avenir26())
    private let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    private let emailTextFieldView = OneLineTextFieldView(labelText: "Email")
    private let passwordTextFieldView = OneLineTextFieldView(labelText: "Password")
    private let confirmPasswordTextFieldView = OneLineTextFieldView(labelText: "Confirm password")
    
    private let signUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonDark())
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
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
        let interactor            = SignUpVipInteractor()
        let presenter             = SignUpVipPresenter()
        let router                = SignUpVipRouter()
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
        setupConstraints()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Routing
    @objc private func signUpButtonTapped() {
        interactor?.makeRequest(
            request: .registerUser(
                email: emailTextFieldView.textField.text,
                password: passwordTextFieldView.textField.text,
                confirmPassword: confirmPasswordTextFieldView.textField.text
            )
        )
    }
    
    // MARK: - Routing
    @objc private func loginButtonTapped() {
        router?.routeToParent()
    }
    
    // MARK: - SignUpVipDisplayLogic
    func displayData(viewModel: SignUpVip.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case let .displayAlert(title, message):
            router?.showAlert(title: title, message: message)
        }
    }
    
}

extension SignUpVipViewController {
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, confirmPasswordTextFieldView, signUpButton], axis: .vertical, spacing: 40)
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        loginButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton], axis: .horizontal, spacing: 10)
        bottomStackView.alignment = .firstBaseline
        
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
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
        }
    }
    
}
