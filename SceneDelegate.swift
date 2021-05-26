//
//
//
//
//
//
//import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let rootView = MainNavigationController.init(rootViewController: HomeController(nibName: "HomeController", bundle: Bundle.main))

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootView
        window?.makeKeyAndVisible()
    }
}
