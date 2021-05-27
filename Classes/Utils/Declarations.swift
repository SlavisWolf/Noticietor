//
//  Declarations.swift
//  Slashmobility
//
//  Created by Antonio Jesús on 24/05/2021.
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
