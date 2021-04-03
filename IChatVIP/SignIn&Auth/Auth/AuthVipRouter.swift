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
    func showAlert(title: String, message: String)
    func routeToMainTabBar()
    func routeToSetupProfile()
}

protocol AuthVipDataPassing {
    var dataStore: AuthVipDataStore? { get }
}

class AuthVipRouter: NSObject, AuthVipRoutingLogic, AuthVipDataPassing {
    
    weak var viewController: AuthVipViewController?
    var dataStore: AuthVipDataStore?
    
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
    
    func showAlert(title: String, message: String) {
        if let viewController = viewController {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { [unowned self] _ in
                if self.dataStore?.muser != nil {
                    self.routeToMainTabBar()
                } else if self.dataStore?.user != nil {
                    self.routeToSetupProfile()
                }
            }
            alertVC.addAction(okAction)
            presentFrom(source: viewController, destination: alertVC)
        }
    }
    
    func routeToMainTabBar() {
        if let viewController = viewController, let homeDS = dataStore, let muser = homeDS.muser {
            let mainTabBarVC = MainTabBarViewController(currentUser: muser)
            mainTabBarVC.modalPresentationStyle = .fullScreen
            presentFrom(source: viewController, destination: mainTabBarVC)
        }
    }
    
    func routeToSetupProfile() {
        if let viewController = viewController, let homeDS = dataStore {
            let detailVC = SetupProfileVipViewController(nibName: nil, bundle: nil)
            if var detailDS = detailVC.router?.dataStore {
                passDataToDetail(source: homeDS, destination: &detailDS)
                presentFrom(source: viewController, destination: detailVC)
            }
        }
    }
    
    // MARK: - Navigation
    
    private func presentFrom(source: UIViewController, destination: UIViewController) {
        source.present(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    private func passDataToDetail(source: AuthVipDataStore, destination: inout SetupProfileVipDataStore) {
        destination.user = source.user
    }
    
}
