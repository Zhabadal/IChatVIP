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
    func showAlert(title: String, message: String, type: AuthVip.AlertType)
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
        let signUpVC = SignUpVipViewController()
        presentFrom(source: viewController!, destination: signUpVC)
    }
    
    func routeToLogin() {
        let loginVC = LoginVipViewController()
        presentFrom(source: viewController!, destination: loginVC)
    }
    
    func showAlert(title: String, message: String, type: AuthVip.AlertType) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            switch type {
            case .authorized:
                self.routeToMainTabBar()
            case .registered:
                self.routeToSetupProfile()
            case .other:
                break
            }
        }
        alertVC.addAction(okAction)
        presentFrom(source: viewController!, destination: alertVC)
    }
    
    func routeToMainTabBar() {
        let mainTabBarVC = MainTabBarViewController(currentUser: dataStore!.muser!)
        mainTabBarVC.modalPresentationStyle = .fullScreen
        presentFrom(source: viewController!, destination: mainTabBarVC)
    }
    
    func routeToSetupProfile() {
        let destinationVC = SetupProfileVipViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetail(source: dataStore!, destination: &destinationDS)
        presentFrom(source: viewController!, destination: destinationVC)
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
