//
//  Declarations.swift
//  
//
//  Created by
//
import UIKit

func mainThread(_ code: @escaping (() -> ())) {
    DispatchQueue.main.async {
        code()
    }
}

func secondThread(_ code: @escaping (() -> ())) {
    DispatchQueue.global(qos: .background).async {
        code()
    }
}

func getScreenWidthPercentage(_ percentage: CGFloat) -> CGFloat {
    UIScreen.main.bounds.width * percentage
}
