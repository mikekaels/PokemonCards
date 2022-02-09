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
    
    func goToCardDetail(from: DiscoveriesVC)
}

protocol DiscoveriesPresenterToRouterProtocol: AnyObject {
    func createModule() -> DiscoveriesVC
    func goToCardDetail(from: DiscoveriesVC)
}

protocol DiscoveriesPresenterToViewProtocol: AnyObject {

}

protocol DiscoveriesInteractorToPresenterProtocol: AnyObject {

}

protocol DiscoveriesPresenterToInteractorProtocol: AnyObject {
    var presenter: DiscoveriesInteractorToPresenterProtocol? { get set }

}
