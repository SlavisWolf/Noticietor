//
//  HomeCell.swift
//  Slashmobility
//
//  Created by Antonio Jesús on 22/05/2021.
//

import UIKit
import RxSwift

class GroupCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    
    let disposeBag = DisposeBag()
    
    static let  cellID = "group_cell_ID"
    //MARK: Ciclo de vida
    override func awakeFromNib() {
        super.awakeFromNib()
        let labelBackgroundColor = UIColor.white.withAlphaComponent(0.8)
        let labelTextColor = Colors.color3
        
        labelName.textColor = labelTextColor
        labelName.font = Fonts.bold(15)
        labelName.backgroundColor = labelBackgroundColor
        
        labelDate.textColor = labelTextColor
        labelDate.font = Fonts.regular(12)
        labelDate.backgroundColor = labelBackgroundColor
        
        labelDesc.textColor = labelTextColor
        labelDesc.font = Fonts.regular(14)
        labelDesc.backgroundColor = labelBackgroundColor
        
        selectionStyle = .none
    }
    
    //MARK: Configuración
    func config(_ group: Group) {
        labelName.text = group.name
        labelDesc.text = group.shortText
        labelDate.text = group.date?.toString()
        imageBackground.setImage(group.imagePath, defaultImage: .groupDefault)
    }
    
    override func prepareForReuse() {
        imageBackground.image = nil
    }
}
