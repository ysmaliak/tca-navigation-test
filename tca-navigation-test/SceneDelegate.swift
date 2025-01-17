//
//  SceneDelegate.swift
//  tca-navigation-test
//
//  Created by Yan Smaliak on 09/09/2024.
//

import ComposableArchitecture
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = AppViewController(store: Store(initialState: AppFeature.State(), reducer: { AppFeature() }))
        self.window = window
        window.makeKeyAndVisible()
    }
}
