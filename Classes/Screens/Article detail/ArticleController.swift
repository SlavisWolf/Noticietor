//
//  ArticleController.swift
//  Unisys
//
//  Created by Antonio Jesús on 27/05/2021.
//

import UIKit

class ArticleController: BaseController {

    
    //MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var topBar: TopBar!
    
    
    var article: Article!
    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()

        
        topBar.config(text: "new".localized(), delegate: self, typeLeft: .back)
        labelTitle.font = Fonts.bold(17)
        labelTitle.textColor = .black
        
        labelContent.font = Fonts.regular(15)
        labelContent.textColor = Colors.color3
        
        labelDate.textColor = Colors.color3
        labelDate.font = Fonts.light(14)
        
        // Datos del articulo
        imageView.setImage(article.imageUrl, defaultImage: .articleDefault)
        labelTitle.text = article.title
        labelContent.text = article.content
        labelDate.text = article.publishedDate.toString()
    }
    //MARK: Top Bar interface
    override func leftClicked(_ sender: UIButton) {
        popController()
    }
}
