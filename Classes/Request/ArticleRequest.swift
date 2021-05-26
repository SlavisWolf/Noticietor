//
//  ArticleRequest.swift
//  
//
//  Created by Antonio Jesús
//
import RxSwift
class ArticleRequest: BaseRequest {

    static let path = "\(Urls.basePath)everything"
    
    func getArticles(_ search: String, sort: String = "publishedAt") -> Single<[Article]> {
        
        let params: Params = ["qInTitle": search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "", "sortBy": sort]
        return makeRequest(path: ArticleRequest.path, params: params, headerParams: ["X-Api-Key" : Constants.articlesApiKey]).map( { response in
            // Obtenemos los datos y los parseamos
            guard let data = response["data"] as? Params,
                let articles = data["articles"] as? [Params]
                else {
                    return [Article]()
                }
            
            return Article.mappingArray(articles)
        })
    }
}
