//
//  ServiceManager.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 11/02/22.
//

import Foundation
import Alamofire

enum CustomError: Error {
    case noInternetConnection
    case unexpected
}

class ServiceManager {
    static let shared = ServiceManager()
    private let httpService = Service()
    
    func fetchCards(page: Int, pageSize: Int, completion: @escaping(Result<Cards, CustomError>) -> Void) {
        if !Connectivity.isConnectedToInternet {
            completion(.failure(.noInternetConnection))
        } else {
            
            do {
                try APIRouter
                    .fetchCards(page: page, pageSize: pageSize)
                    .request(usingHttpService: httpService)
                    .responseJSON { result in
                        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }
                        do {
                            let result = try JSONDecoder().decode(Cards.self, from: data)
                            completion(.success(result))
                        } catch {
                            completion(.failure(error as! CustomError))
                        }
                    }
                
            } catch {
                completion(.failure(error as! CustomError))
            }
        }
    }
    
    func findCard(name: String, page: Int, pageSize: Int, completion: @escaping(Result<Cards, CustomError>) -> Void) {
        if !Connectivity.isConnectedToInternet {
            completion(.failure(.noInternetConnection))
        } else {
            do {
                try APIRouter
                    .findCard(name: name, page: page, pageSize: pageSize)
                    .request(usingHttpService: httpService)
                    .responseJSON { result in
                        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }
                        do {
                            let result = try JSONDecoder().decode(Cards.self, from: data)
                            completion(.success(result))
                        } catch {
                            completion(.failure(.unexpected))
                        }
                    }
                
            } catch {
                completion(.failure(error as! CustomError))
            }
        }
    }
    
    func getCardDetails(id: String, completion: @escaping(Result<CardDetails, CustomError>) -> Void) {
        if !Connectivity.isConnectedToInternet {
            completion(.failure(.noInternetConnection))
        } else {
            do {
                try APIRouter
                    .getCardDetails(id: id)
                    .request(usingHttpService: httpService)
                    .responseJSON { result in
                        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }
                        do {
                            let result = try JSONDecoder().decode(CardDetails.self, from: data)
                            completion(.success(result))
                        } catch {
                            completion(.failure(error as! CustomError))
                        }
                    }
                
            } catch {
                completion(.failure(error as! CustomError))
            }
        }
    }
    
    func getOtherCards(id: String, type: String, page: Int, pageSize: Int, completion: @escaping(Result<Cards, CustomError>) -> Void) {
        if !Connectivity.isConnectedToInternet {
            completion(.failure(.noInternetConnection))
        } else {
            do {
                try APIRouter
                    .getOtherCards(id: id, type: type, page: page, pageSize: pageSize)
                    .request(usingHttpService: httpService)
                    .responseJSON { result in
                        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }
                        do {
                            let result = try JSONDecoder().decode(Cards.self, from: data)
                            completion(.success(result))
                        } catch {
                            completion(.failure(error as! CustomError))
                        }
                    }
                
            } catch {
                completion(.failure(error as! CustomError))
            }
        }
    }
}
