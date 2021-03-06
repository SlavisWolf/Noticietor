//
//  Article.swift
//  Unisys
//
//  Created by Antonio Jesús on 26/05/2021.
//

import UIKit

class Article {
    var id: String!
    var title: String!
    var shortText: String!
    var content: String!
    var source: String!
    var imageUrl: URL?
    var publishedDate: Date!
    
    static func mapping( _ params: Params) -> Article {
        let model = Article()
        //        model.id = (params["id"] as! Int)
        model.title = params["title"] as? String ?? ""
        model.shortText = params["description"] as? String ?? ""
        model.content = params["content"] as? String ?? ""
        model.imageUrl = URL(string: params["urlToImage"] as? String ?? "")
        model.publishedDate = Date.castStringWith8601Format(params["publishedAt"] as! String)!
        model.source = ((params["source"] as! Params)["name"] as! String)
        model.id = model.createId()
        return model
    }
    
    private func createId() -> String {
        String("\(title ?? "")_\(source ?? "")_\(publishedDate.toStringWith8601() )".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!.hash)
    }

    static func mappingArray(_ list: [Params]) -> [Article] {
        list.map({mapping($0)})
    }
}
