//
//  UIImageView+Extension.swift
//  
//
//  Created by Antonio Jesús
//

import UIKit
import Kingfisher

enum ImageError: String {
    case articleDefault = "defaultarticle"
}
extension UIImageView {
    
    func setImage(_ url: URL?, defaultImage: ImageError) {
        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, options: [KingfisherOptionsInfoItem.cacheOriginalImage], completionHandler: { result in
            switch result {
                case .failure(_):
                    self.image = UIImage(named: defaultImage.rawValue)
                default:
                    break
            }
        })
    }
    
}
