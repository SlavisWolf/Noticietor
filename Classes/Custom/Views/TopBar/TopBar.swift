//
//  TopBar.swift
//  
//
//  Created by Antonio Jesús .
//

import UIKit

@objc protocol TopBarInterface where Self: BaseController {
    @objc func leftClicked(_ sender: UIButton)
    @objc func rightClicked(_ sender: UIButton)
    @objc func right2Clicked(_ sender: UIButton)
}

enum ButtonType: String {
    case none
    case back
    case more
    case refresh
}

class TopBar: ViewDecoded {
    
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var buttonRight2: UIButton!
    
    var typeLeft: ButtonType!
    var typeRight: ButtonType!
    var typeRight2: ButtonType!

    
    // MARK: View lifecycle
    override func awakeFromNib() {
        labelTitle.textColor = .white
        labelTitle.font = Fonts.regular(20)
        backgroundColor = Colors.color1
    }

    func config(text: String, delegate: TopBarInterface, typeLeft: ButtonType = .none, typeRight: ButtonType = .none, typeRight2: ButtonType = .none) {
        
        labelTitle.text = text
        
        configActions(delegate)
        self.typeLeft = typeLeft
        self.typeRight = typeRight
        self.typeRight2 = typeRight2
                
        selectImage(button: buttonLeft, buttonType: typeLeft)
        selectImage(button: buttonRight, buttonType: typeRight)
        selectImage(button: buttonRight2, buttonType: typeRight2)
        
    }
    
    //MARK: Private
    private func configActions(_ delegate: TopBarInterface) {
        // Configuramos los target de los botones al delegado
        buttonLeft.removeTarget(nil, action: nil, for: .allEvents)
        buttonLeft.addTarget(delegate, action: #selector(delegate.leftClicked(_:)), for: .touchUpInside)
        
        buttonRight.removeTarget(nil, action: nil, for: .allEvents)
        buttonRight.addTarget(delegate, action: #selector(delegate.rightClicked(_:)), for: .touchUpInside)
        
        buttonRight2.removeTarget(nil, action: nil, for: UIControl.Event.allEvents)
        buttonRight2.addTarget(delegate, action: #selector(delegate.right2Clicked(_:)), for: .touchUpInside)
    }
    
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
    
}

    


