//
//  CardDetailsRouter.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 09/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.


import UIKit

public class CardDetailsRouter: CardDetailsPresenterToRouterProtocol{
    public static let shared = CardDetailsRouter()
    
    func initialize() -> CardDetailsVC {
        return createModule()
    }
    
    func createModule() -> CardDetailsVC {
        let view = CardDetailsVC()
        
        let presenter: CardDetailsViewToPresenterProtocol & CardDetailsInteractorToPresenterProtocol = CardDetailsPresenter()
        
        let interactor: CardDetailsPresenterToInteractorProtocol = CardDetailsInteractor()
        
        let router: CardDetailsPresenterToRouterProtocol = CardDetailsRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func goToNextCard(id: String, from: CardDetailsVC) {
        let vc = createModule()
        vc.id = id
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
