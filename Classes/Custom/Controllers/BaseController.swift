//
//  MainController.swift
//  
//
//  Created by Antonio Jesús
//
import UIKit
import RxSwift

class BaseController: UIViewController, TopBarInterface {
    //MARK: Variables
    let disposeBag = DisposeBag()
    
    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.color2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: TopBarInterface
    @objc func leftClicked(_ sender: UIButton) {}
    
    @objc func rightClicked(_ sender: UIButton){}
    
    @objc func right2Clicked(_ sender: UIButton) {}
    
    //MARK: Métodos de navegación
    func popController(_ animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func pushController(_ controller: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
