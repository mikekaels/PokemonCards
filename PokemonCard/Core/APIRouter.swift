//
//  APIRouter.swift
//  PokemonCard
//
//  Created by Santo Michael Sihombing on 10/02/22.
//

import Foundation
import Alamofire

enum APIRouter {
    case fetchCards(page: Int, pageSize: Int)
    case findCard(name: String, page: Int, pageSize: Int)
    case getCardDetails(id: String)
}

extension APIRouter: HttpRouter {
    
    var baseURL: String {
        switch self {
        default :
            return "https://api.pokemontcg.io/v2";
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchCards, .findCard, .getCardDetails: return .get
        }
    }
    
    var headers: HTTPHeaders {
        return [
            "Content-Type": "application/json; charset=UTF-8",
            "X-Api-Key":"2ddd7d63-7c32-45ee-8660-e668b17abbbe"
        ]
    }
    
    var path: String {
        switch self {
        case .getCardDetails(let id): return "cards/\(id)"
        default: return "cards"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        default: return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchCards(let page, let pageSize):
            return [
                "page":page,
                "pageSize":pageSize
            ]
        case .findCard(let name, let page, let pageSize):
            return [
                "page": page,
                "pageSize": pageSize,
                "q": "name:\(name)",
            ]
        default: return [:]
        }
    }
    
    var body: Parameters? {
        switch self {
        default: return nil
        }
    }
}

protocol HttpRouter: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    
    func body() throws -> Data?
    
    func request(usingHttpService service: HttpService) throws -> DataRequest
}

extension HttpRouter {
    var parameter: Parameters? { return nil }
    
    func body() throws -> Data? { return nil }
    
    func asURLRequest() throws -> URLRequest {

        var url =  try urlComponent().asURL()
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        
        return request
    }
    
    func urlComponent() throws -> URLComponents {
        var components = URLComponents(string: baseURL)!
        
        guard parameters != nil, let parameters = parameters else {
            return components
        }

        let items: [URLQueryItem] = parameters.map { (key, value) in
            return URLQueryItem(name: key, value: String(describing: value))
        }
        
        components.queryItems = items
        
        return components
    }
    
    func request(usingHttpService service: HttpService) throws -> DataRequest {
        return try service.request(asURLRequest())
    }
}
