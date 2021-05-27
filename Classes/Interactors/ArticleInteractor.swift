//
//  ArticleInteractor.swift
//
//
//  Created by Antonio Jesús
//

import RxSwift

class ArticleInteractor {
    
    private static  let request = ArticleRequest()
    private static let databaseManager = ArticleDatabaseManager()
    
    static func searchArticles(_ search: String) -> Single<[Article]> {
        // Primero intentamos obtener los datos del servidor, sino los conseguimos iremos a la BD local
        return request.getArticles(search).flatMap({ articles in
            // Guardamos o actualizamos los registros en la BD local en otro hilo
            secondThread {databaseManager.saveList(articles)}
            return Single.just(articles)
        }).catch({ error in
            //Buscamos los datos en la BD local sino hay nos devolverá un array vacio.
            return Single.just(databaseManager.searchByTitle(search))
        })
    }
}

