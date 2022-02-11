//
//  DiscoveriesProtocol.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 08/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

public protocol DiscoveriesDelegate {
    
}

protocol DiscoveriesViewToPresenterProtocol: AnyObject {
    var view: DiscoveriesPresenterToViewProtocol? { get set }
    var interactor: DiscoveriesPresenterToInteractorProtocol? { get set }
    var router: DiscoveriesPresenterToRouterProtocol? { get set }
    
    func goToCardDetail(id: String, from: DiscoveriesVC)
    func fetchCards(page: Int, pageSize: Int)
    func findCards(name: String, page: Int, pageSize: Int)
}

protocol DiscoveriesPresenterToRouterProtocol: AnyObject {
    func createModule() -> DiscoveriesVC
    func goToCardDetail(id: String, from: DiscoveriesVC)
}

protocol DiscoveriesPresenterToViewProtocol: AnyObject {
    func didFetchCards(cards: Cards)
    func didErrorFetchCards(error: CustomError)
}

protocol DiscoveriesInteractorToPresenterProtocol: AnyObject {
    func didFetchCards(result: Result<Cards, CustomError>)
}

protocol DiscoveriesPresenterToInteractorProtocol: AnyObject {
    var presenter: DiscoveriesInteractorToPresenterProtocol? { get set }
    func fetchCards(page: Int, pageSize: Int)
    func findCards(name: String, page: Int, pageSize: Int)
}
