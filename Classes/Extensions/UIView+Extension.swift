//
//  UIView+Extension.swift
//  
//
//  Created by Antonio Jesús
//
import UIKit


extension UIView {
    
    
    var parentViewController: UIViewController? {
            var parentResponder: UIResponder? = self
            while parentResponder != nil {
                parentResponder = parentResponder?.next
                if let viewController = parentResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
    
    static func create(index: Int = 0) -> Self {
        
        func instanceFromNib<T: UIView>() -> T {
            return UINib(nibName: "\(self)", bundle: nil).instantiate(withOwner: nil, options: nil)[index] as! T
        }
        
        return instanceFromNib()
    }
    
    func setCornerRadius(_ radius: CGFloat, mask: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]) {
        layer.maskedCorners = mask
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
