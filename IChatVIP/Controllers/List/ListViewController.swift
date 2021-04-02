//
//  ListViewController.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ListDisplayLogic: class {
    func displayData(viewModel: List.Model.ViewModel.ViewModelData)
}

class ListViewController: UIViewController, ListDisplayLogic {
    
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic & ListDataPassing)?
    
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
        let interactor            = ListInteractor()
        let presenter             = ListPresenter()
        let router                = ListRouter()
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
        
        view.backgroundColor = .blue
    }
    
    // MARK: - ListDisplayLogic
    
    func displayData(viewModel: List.Model.ViewModel.ViewModelData) {
        
    }
    
}
