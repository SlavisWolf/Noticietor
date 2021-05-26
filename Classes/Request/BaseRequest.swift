//
//  MainRequest.swift
//  Slashmobility
//
//  Created by Antonio Jesús on 20/05/2021.
//
import UIKit
import  RxSwift

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

typealias Params = [String:Any]

//Esta será la clase principal  para las peticiones.
class BaseRequest {
    
     func makeRequest(path: String, method: HttpMethod = .get) -> Single<Params>  {
        return Single.create(subscribe: { single -> Disposable in
            guard let url = URL(string: path) else {
                single(.failure(ErrorManager.createError(domain: "Invalid URL")))
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
                guard let data = data else {
                    single(.failure(error ?? ErrorManager.createError(domain: "Empty data")))
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    // Intentaremos que siempre devuelva el mismo tipo de valor para que luego podamos parsearlo en el request correspondiente, pero todos los request deben recibir un objeto de tipo Params
                    single(.success(["data": json]))
                } catch {
                    single(.failure(ErrorManager.createError(domain: "Error parsing")))
                }
            })
            task.resume()
            return Disposables.create()
        }).observe(on: MainScheduler.instance)
     }
}
