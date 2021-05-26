//
//  ViewDecoded.swift
//  
//
//  Created by Antonio Jesús
//

import UIKit
import  SnapKit

class ViewDecoded: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    init()
    {
        super.init(frame: .zero)
        config()
    }
    
    private func config() {
        let view =  Bundle.main.loadNibNamed(nibname(), owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.snp.makeConstraints({$0.edges.equalToSuperview()})

    }
    
    func nibname() -> String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
