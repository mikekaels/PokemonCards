//
//  CardDetailsProtocol.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 09/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

public protocol CardDetailsDelegate {
    
}

protocol CardDetailsViewToPresenterProtocol: AnyObject {
    var view: CardDetailsPresenterToViewProtocol? { get set }
    var interactor: CardDetailsPresenterToInteractorProtocol? { get set }
    var router: CardDetailsPresenterToRouterProtocol? { get set }
}

protocol CardDetailsPresenterToRouterProtocol: AnyObject {
    func createModule() -> CardDetailsVC
}

protocol CardDetailsPresenterToViewProtocol: AnyObject {

}

protocol CardDetailsInteractorToPresenterProtocol: AnyObject {

}

protocol CardDetailsPresenterToInteractorProtocol: AnyObject {
    var presenter: CardDetailsInteractorToPresenterProtocol? { get set }

}
