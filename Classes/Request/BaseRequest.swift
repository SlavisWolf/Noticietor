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
    
    func makeRequest(path: String, params: Params, headerParams: [String : String]? = nil, method: HttpMethod = .get) -> Single<Params>  {
        return Single.create(subscribe: { single -> Disposable in
            guard var urlComponents = URLComponents(string: path) else {
                single(.failure(ErrorManager.createError(domain: "Invalid URL")))
                return Disposables.create()
            }
            //Añadimos los parametros al body o a la url según el método de la petición
            var jsonData: Data? = nil
            if !params.isEmpty {
                if method == .get {
                    urlComponents.queryItems = params.map({URLQueryItem(name: $0, value: $1 as? String)})
                }
                else {
                    jsonData = try? JSONSerialization.data(withJSONObject: params)
                }
            }
        
            // Creamos la petición
            guard let url = urlComponents.url else {
                single(.failure(ErrorManager.createError(domain: "Invalid URL")))
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = method.rawValue
            request.httpBody = jsonData
            // Headers
            headerParams?.forEach({request.setValue($1, forHTTPHeaderField: $0)})
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
                guard let data = data else {
                    single(.failure(error ?? ErrorManager.createError(domain: "Empty data")))
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    
                    if let dict = json as? Params, (dict["status"] as! String) == "error" {
                        single(.failure(ErrorManager.createError(domain: dict["message"] as? String ?? "")))
                    }
                    else {
                        // Intentaremos que siempre devuelva el mismo tipo de valor para que luego podamos parsearlo en el request correspondiente, pero todos los request deben recibir un objeto de tipo Params
                        single(.success(["data": json]))
                    }
                    
                } catch {
                    single(.failure(ErrorManager.createError(domain: "Error parsing")))
                }
            })
            task.resume()
            return Disposables.create()
        }).observe(on: MainScheduler.instance)
     }
}
