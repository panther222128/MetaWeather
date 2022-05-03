//
//  SceneDelegate.swift
//  MetaWeather
//
//  Created by Jun Ho JANG on 2022/04/28.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewModel = DefaultMetaWeatherViewModel()
        guard let weatherViewController = storyboard.instantiateViewController(withIdentifier: "MetaWeatherViewControllerID") as? MetaWeatherViewController else { return }
        weatherViewController.instantiateWeatherViewController(with: viewModel)
        window?.rootViewController = weatherViewController
    }

}

