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
    
    func fetchCardDetails(id: String)
}

protocol CardDetailsPresenterToRouterProtocol: AnyObject {
    func createModule() -> CardDetailsVC
}

protocol CardDetailsPresenterToViewProtocol: AnyObject {
    func didFetchCardDetails(card: Card)
    func didErrorFetchCardDetails(error: CustomError)
}

protocol CardDetailsInteractorToPresenterProtocol: AnyObject {
    func didFetchCardDetails(result: Result<CardDetails, CustomError>)
}

protocol CardDetailsPresenterToInteractorProtocol: AnyObject {
    var presenter: CardDetailsInteractorToPresenterProtocol? { get set }
    func fetchCardDetails(id: String)
}
