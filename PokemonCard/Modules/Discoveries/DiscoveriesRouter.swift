//
//  DiscoveriesRouter.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 08/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

public class DiscoveriesRouter: DiscoveriesPresenterToRouterProtocol{
    public static let shared = DiscoveriesRouter()
    
    func initialize() -> DiscoveriesVC {
        return createModule()
    }
    
    func createModule() -> DiscoveriesVC {
        let view = DiscoveriesVC()
        
        let presenter: DiscoveriesViewToPresenterProtocol & DiscoveriesInteractorToPresenterProtocol = DiscoveriesPresenter()
        
        let interactor: DiscoveriesPresenterToInteractorProtocol = DiscoveriesInteractor()
        
        let router: DiscoveriesPresenterToRouterProtocol = DiscoveriesRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func goToCardDetail(id: String, from: DiscoveriesVC) {
        let vc = CardDetailsRouter.shared.createModule()
        vc.id = id
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
