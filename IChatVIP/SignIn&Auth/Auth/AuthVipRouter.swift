//
//  AuthVipRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AuthVipRoutingLogic {
    func routeToSignUp()
    func routeToLogin()
}

class AuthVipRouter: NSObject, AuthVipRoutingLogic {
    
    weak var viewController: AuthVipViewController?
    
    // MARK: Routing
    func routeToSignUp() {
        guard let viewController = viewController else { fatalError("Fail route to signUp") }
        let signUpVC = SignUpVipViewController(nibName: nil, bundle: nil)
        presentFrom(source: viewController, destination: signUpVC)
    }
    
    func routeToLogin() {
        guard let viewController = viewController else { fatalError("Fail route to login") }
        let loginVC = LoginVipViewController(nibName: nil, bundle: nil)
        presentFrom(source: viewController, destination: loginVC)
    }
    
    // MARK: - Navigation
    private func presentFrom(source: UIViewController, destination: UIViewController) {
        source.present(destination, animated: true)
    }
    
}
