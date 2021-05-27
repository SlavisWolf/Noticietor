//
//  ArticleDatabaseManager.swift
//  Unisys
//
//  Created by Antonio Jesús on 27/05/2021.
//

import UIKit

class ArticleDatabaseManager: BaseDatabaseManager, DatabaseManagerInterface {
    

    let entity = "ArticleLocal"
    //MARK: Funciones para crear, modificar o borrar objetos
    func save(_ model: Article) {
        
        createOrUpdate(model)
        //Guardamos los cambios pendientes
        savePendingChanges()
    }
    
    func saveList(_ articles: [Article]) {
        //Buscamos los objetos en la bd, si existen los actualizamos, sino los creamos
        articles.forEach({createOrUpdate($0)})
        //Guardamos los cambios pendientes
        savePendingChanges()
    }
    
    func createOrUpdate(_ model: Article) {
        // Comprobamos si el objeto existe en la BD, si existe lo actualizamos, sino lo creamos.
        if let object = getObject(model.id) {
            object.publishedDate = model.publishedDate
            object.title = model.title
            object.content = model.content
            object.source = model.source
            object.shortText = model.shortText
            object.imageUrl = model.imageUrl?.absoluteString
        }
        
        else {
            let _ = castToContextObject(model)
        }
    }
    
    //MARK: Funciones para leer objetos
    func get(_ id: String) -> Article? {
        guard let object = getObject(id) else {return nil}
        return mappingContextObject(object)
    }
    
    func getObject(_ id: String) -> ArticleLocal? {
        return fetchRequest(entity: entity, predicate: NSPredicate(format: "id = %@", id)).first
    }
    
    func getAll(_ predicate: NSPredicate? = nil, sort: [NSSortDescriptor]? = nil) -> [Article] {
        return mappingContextObjects(fetchRequest(entity: entity, predicate: predicate, sort: sort))
    }
    
    func searchByTitle(_ search: String, sort: String = "publishedDate") -> [Article] {
        // La c es para que la búsqueda sea case-insensitive y la d para las tíldes
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", search)
        let sort = NSSortDescriptor(key: sort, ascending: false)
        return getAll(predicate, sort: [sort])
    }
    
    //MARK: Métodos para mapear
     func mappingContextObject(_ object: ArticleLocal) -> Article {
        let model = Article()
        model.id = object.id
        model.title = object.title
        model.imageUrl = URL(string: object.imageUrl ?? "")
        model.shortText = object.shortText
        model.content = object.content
        model.source = object.source
        model.publishedDate = object.publishedDate
        return model
    }
    
     func mappingContextObjects(_ objects: [ArticleLocal]) -> [Article] {
        objects.map({mappingContextObject($0)})
    }
    
    func castToContextObject(_ model: Article)  -> ArticleLocal {
        
        let newArticle = ArticleLocal(context: context)
        newArticle.id = model.id
        newArticle.imageUrl = model.imageUrl?.absoluteString
        newArticle.title = model.title
        newArticle.content = model.content
        newArticle.shortText = model.shortText
        newArticle.publishedDate = model.publishedDate
        newArticle.source = model.source
        return newArticle
    }
}
