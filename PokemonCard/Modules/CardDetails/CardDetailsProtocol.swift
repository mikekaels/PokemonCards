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
    func getOtherCards(id: String, type: String, page: Int, pageSize: Int)
    func goToNextCard(id: String, from: CardDetailsVC)
}

protocol CardDetailsPresenterToRouterProtocol: AnyObject {
    func createModule() -> CardDetailsVC
    func goToNextCard(id: String, from: CardDetailsVC)
}

protocol CardDetailsPresenterToViewProtocol: AnyObject {
    func didFetchCardDetails(card: Card)
    func didErrorFetchCardDetails(error: CustomError)
    func didGetOtherCards(cards: Cards)
    func didErrorGetOtherCards(error: CustomError)
}

protocol CardDetailsInteractorToPresenterProtocol: AnyObject {
    func didFetchCardDetails(result: Result<CardDetails, CustomError>)
    func didGetOtherCards(result: Result<Cards, CustomError>)
}

protocol CardDetailsPresenterToInteractorProtocol: AnyObject {
    var presenter: CardDetailsInteractorToPresenterProtocol? { get set }
    func fetchCardDetails(id: String)
    func getOtherCards(id: String, type: String, page: Int, pageSize: Int)
}
