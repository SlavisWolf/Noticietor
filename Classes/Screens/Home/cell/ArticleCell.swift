//
//  ArticleCell.swift
//  Unisys
//
//  Created by Antonio Jesús on 27/05/2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.setCornerRadius(13)
        viewContent.backgroundColor = .white
        labelTitle.font = Fonts.bold(17)
        labelTitle.textColor = .black
        labelContent.font = Fonts.regular(15)
        labelContent.textColor = Colors.color3
        selectionStyle = .none
    }
    
    func config(_ article: Article) {
        labelTitle.text = article.title
        labelContent.text = article.shortText
        imageArticle.setImage(article.imageUrl, defaultImage: .articleDefault)
    }
}
