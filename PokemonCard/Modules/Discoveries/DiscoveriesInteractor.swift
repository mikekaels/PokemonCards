//
//  DiscoveriesInteractor.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 08/02/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Alamofire

class DiscoveriesInteractor: DiscoveriesPresenterToInteractorProtocol {
    weak var presenter: DiscoveriesInteractorToPresenterProtocol?
    private let serviceManager = ServiceManager.shared
}

extension DiscoveriesInteractor {
    func fetchCards(page: Int, pageSize: Int) {
        serviceManager.fetchCards(page: page, pageSize: pageSize) { result in
            self.presenter?.didFetchCards(result: result)
        }
    }
    
    func findCards(name: String, page: Int, pageSize: Int) {
        serviceManager.findCard(name: name, page: page, pageSize: pageSize) { result in
            self.presenter?.didFetchCards(result: result)
        }
    }
}

