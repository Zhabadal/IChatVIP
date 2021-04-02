//
//  PeopleViewController.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PeopleDisplayLogic: class {
    func displayData(viewModel: People.Model.ViewModel.ViewModelData)
}

class PeopleViewController: UIViewController, PeopleDisplayLogic {
    
    var interactor: PeopleBusinessLogic?
    var router: (NSObjectProtocol & PeopleRoutingLogic & PeopleDataPassing)?
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = PeopleInteractor()
        let presenter             = PeoplePresenter()
        let router                = PeopleRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(signOut))
    }
    
    @objc private func signOut() {
        router?.showAlert(title: nil, message: "Are you sure you want to sign out?")
    }
    
    // MARK: - PeopleDisplayLogic
    
    func displayData(viewModel: People.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayAuth:
            router?.routeToAuth()
        }
    }
    
}
