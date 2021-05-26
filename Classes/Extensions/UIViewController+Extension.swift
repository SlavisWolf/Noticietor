//
//  UIViewController+extension.swift
//  
//
//  Created by Antonio Jesús
//
import UIKit

extension UIViewController {
    
    class func create() -> Self {
        // Obtenemos el nombre y lo separamos de la extensión
        var className = NSStringFromClass(object_getClass(self)!)
        let array = className.components(separatedBy: ".")
        if array.count > 1 {
            className = array[1]
        }
        // Obtenemos la ruta del xib
        let path = Bundle.main.path(forResource: className, ofType: "nib")
        //Inicializamos el controller con el nib que hemos conseguido
        if path != nil {
            return self.init(nibName: className, bundle: nil)
        }
        
        else {
            return self.init(nibName: nil, bundle: nil)
        }
    }

}
