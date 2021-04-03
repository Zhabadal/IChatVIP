//
//  ChatRequestRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ChatRequestRoutingLogic {
    //func routeToSomewhere()
}

protocol ChatRequestDataPassing {
    var dataStore: ChatRequestDataStore? { get }
}

class ChatRequestRouter: NSObject, ChatRequestRoutingLogic, ChatRequestDataPassing {
    
    weak var viewController: ChatRequestViewController?
    var dataStore: ChatRequestDataStore?
    
    // MARK: Routing
    
//    func routeToSomewhere() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        navigateToSomewhere(source: viewController!, destination: destinationVC)
//    }

    // MARK: Navigation
    
//    func navigateToSomewhere(source: ChatRequestViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }

    // MARK: Passing data
    
//    func passDataToSomewhere(source: ChatRequestDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }

}
