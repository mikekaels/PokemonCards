//
//  DiscoveriesPresenter.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 08/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

class DiscoveriesPresenter: DiscoveriesViewToPresenterProtocol {
    weak var view: DiscoveriesPresenterToViewProtocol?
    var router: DiscoveriesPresenterToRouterProtocol?
    var interactor: DiscoveriesPresenterToInteractorProtocol?
    
    func goToCardDetail(id: String, from: DiscoveriesVC) {
        router?.goToCardDetail(id: id, from: from)
    }
    
    func fetchCards(page: Int, pageSize: Int) {
        interactor?.fetchCards(page: page, pageSize: pageSize)
    }
    
    func findCards(name: String, page: Int, pageSize: Int) {
        interactor?.findCards(name: name, page: page, pageSize: pageSize)
    }
}

extension DiscoveriesPresenter: DiscoveriesInteractorToPresenterProtocol {
    func didFetchCards(result: Result<Cards, CustomError>) {
        switch result {
        case .success(let cards):
            self.view?.didFetchCards(cards:cards)
        case .failure(let error):
            self.view?.didErrorFetchCards(error: error)
        }
    }
    
    
}
