//
//  TopSearchBar.swift
//  Unisys
//
//  Created by Antonio Jesús on 27/05/2021.
//

import UIKit
import SnapKit
protocol TopSearchBarInterface  {
    
    func leftClicked(_ sender: UIButton)
    func fieldReturn(_ text: String?)
}

class TopSearchBar: ViewDecoded, UITextFieldDelegate {
    
    
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var fieldSearch: UITextField!
    
    var typeLeft: ButtonType!
    var delegate: TopSearchBarInterface!
    
    
    // MARK: View lifecycle
    override func awakeFromNib() {
        labelTitle.textColor = .white
        labelTitle.font = Fonts.regular(20)
        backgroundColor = Colors.color1
        
        fieldSearch.font = Fonts.regular(18)
        fieldSearch.textColor = Colors.color3
        fieldSearch.delegate = self
        
        fieldSearch.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(image: UIImage(named: "nav_search"))
        let image = UIImage(named: "nav_search")
        imageView.image = image
        fieldSearch.leftView = imageView
        
    }

    func config(text: String, delegate: TopSearchBarInterface, typeLeft: ButtonType = .none) {
        
        labelTitle.text = text
        self.delegate = delegate
        self.typeLeft = typeLeft
                
        selectImage(button: buttonLeft, buttonType: typeLeft)
    }
    
    //MARK: Private
    
    private func selectImage(button: UIButton, buttonType: ButtonType) {
        // En caso de que sea el tipo sea none ocultamos el botón.
        if buttonType == .none {
            button.setImage(nil, for: .normal)
            button.isUserInteractionEnabled = false
            button.snp.remakeConstraints({ maker in maker.width.equalTo(0) })
            return
        }
        
        button.isUserInteractionEnabled = true
        button.isHidden = false
        
        let nameImg = buttonType.rawValue
        
        button.setImage(UIImage(named: "nav_\(nameImg)"), for: .normal)
    }

    //MARK: Actions
    @IBAction func leftClicked(_ sender: UIButton) {
        delegate.leftClicked(sender)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate.fieldReturn(textField.text)
        return true
    }
}
