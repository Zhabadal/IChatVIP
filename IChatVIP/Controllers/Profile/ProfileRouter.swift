//
//  ProfileRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfileRoutingLogic {
    func routeToParent()
}

protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing {
    
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
    
    // MARK: Routing
    
    func routeToParent() {
        let mainTabBarVC = viewController?.presentingViewController as! MainTabBarViewController
        let navVC = mainTabBarVC.viewControllers?[0] as! UINavigationController
        let destinationVC = navVC.topViewController as! PeopleViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToParent(source: dataStore!, destination: &destinationDS)
        navigateToParent(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation
    
    func navigateToParent(source: ProfileViewController, destination: PeopleViewController) {
        source.dismiss(animated: true) {
            destination.interactor?.makeRequest(request: .createWaitingChat)
        }
    }

    // MARK: Passing data
    
    func passDataToParent(source: ProfileDataStore, destination: inout PeopleDataStore) {
        destination.message = source.message
    }

}
