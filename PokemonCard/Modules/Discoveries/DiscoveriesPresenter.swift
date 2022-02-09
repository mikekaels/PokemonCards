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
    
    func goToCardDetail(from: DiscoveriesVC) {
        router?.goToCardDetail(from: from)
    }
}

extension DiscoveriesPresenter: DiscoveriesInteractorToPresenterProtocol {

}
