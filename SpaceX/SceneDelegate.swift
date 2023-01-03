//
//  SceneDelegate.swift
//  SpaceX
//
//  Created by Богдан Баринов on 02.08.2022.
//

import UIKit

//MARK: - SceneDelegate

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //MARK: - Public property

    var window: UIWindow?

    //MARK: - Public method

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = RocketSpaceXViewController()
    }
}
