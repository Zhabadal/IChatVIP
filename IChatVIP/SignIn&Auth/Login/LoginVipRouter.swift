//
//  LoginVipRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginVipRoutingLogic {
    func routeToParent()
    func showAlert(title: String, message: String)
    func routeToMainTabBar()
    func routeToSetupProfile()
}

protocol LoginVipDataPassing {
    var dataStore: LoginVipDataStore? { get }
}

class LoginVipRouter: NSObject, LoginVipRoutingLogic, LoginVipDataPassing {
    
    weak var viewController: LoginVipViewController?
    var dataStore: LoginVipDataStore?
    
    // MARK: Routing
    func routeToParent() {
        let destinationVC = viewController?.presentingViewController as! AuthVipViewController
        navigateToParent(source: viewController!, destination: destinationVC)
    }
    
    func showAlert(title: String, message: String) {
        if let viewController = viewController {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                viewController.interactor?.makeRequest(request: .getUserData)
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
    func navigateToParent(source: LoginVipViewController, destination: AuthVipViewController) {
        source.dismiss(animated: true) {
            destination.router?.routeToSignUp()
        }
    }
    
    private func presentFrom(source: UIViewController, destination: UIViewController) {
        source.present(destination, animated: true)
    }
    
    // MARK: - Passing data
    private func passDataToDetail(source: LoginVipDataStore, destination: inout SetupProfileVipDataStore) {
        destination.user = source.user
    }
    
}
