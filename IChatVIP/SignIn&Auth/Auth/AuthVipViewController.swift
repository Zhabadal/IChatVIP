//
//  AuthVipViewController.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AuthVipDisplayLogic: class {
    func displayData(viewModel: AuthVip.Model.ViewModel.ViewModelData)
}

class AuthVipViewController: UIViewController, AuthVipDisplayLogic {
    
    // MARK: - Global Properties
    var interactor: AuthVipBusinessLogic?
    var router: (NSObjectProtocol & AuthVipRoutingLogic)?
    
    // MARK: - Local Properties
    private let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)
    
    private let googleLabel = UILabel(text: "Get started with")
    private let emailLabel = UILabel(text: "Or sign up with")
    private let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    private let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonDark())
    private let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    
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
        let interactor            = AuthVipInteractor()
        let presenter             = AuthVipPresenter()
        let router                = AuthVipRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Routing
    @objc private func emailButtonTapped() {
        router?.routeToSignUp()
    }
    
    @objc private func loginButtonTapped() {
        router?.routeToLogin()
    }
    
    // MARK: - AuthVipDisplayLogic
    func displayData(viewModel: AuthVip.Model.ViewModel.ViewModelData) {
        
    }
    
}

// MARK: - Setup UI
extension AuthVipViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        googleButton.customizeGoogleButton()
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(160)
            make.centerX.equalToSuperview()
        }
        
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let alreadyOnboardView = ButtonFormView(label: alreadyOnboardLabel, button: loginButton)
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, alreadyOnboardView], axis: .vertical, spacing: 40)
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(160)
            make.left.right.equalToSuperview().inset(40)
        }
    }
    
}
