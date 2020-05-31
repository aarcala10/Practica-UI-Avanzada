//
//  AppCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator principal de la app. Encapsula todas las interacciones con la Window.
/// Tiene dos hijos, el topic list, y el categories list (uno por cada tab)
class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()

    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()

    lazy var localDataManager: DiscourseClientLocalDataManager = {
        let localDataManager = DiscourseClientLocalDataManagerImpl()
        return localDataManager
    }()

    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(localDataManager: self.localDataManager, remoteDataManager: self.remoteDataManager)
        return dataManager
    }()

    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let tabBarController = UITabBarController()

        let topicsNavigationController = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager,
                                                  userDataManager: dataManager,
                                                  topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()

        let categoriesNavigationController = UINavigationController()
        let categoriesCoordinator = CategoriesCoordinator(presenter: categoriesNavigationController, categoriesDataManager: dataManager)
        addChildCoordinator(categoriesCoordinator)
        categoriesCoordinator.start()

        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController, usersDataManager: dataManager, userDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()

        
        tabBarController.viewControllers = [topicsNavigationController, usersNavigationController, categoriesNavigationController,]
        
        tabBarController.tabBar.tintColor = .pumpkin
        
        
        tabBarController.tabBar.items?[0].title = "Inicio"
        tabBarController.tabBar.items?[0].image = UIImage(imageLiteralResourceName: "inicioUnselected")
        tabBarController.tabBar.items?[0].selectedImage = UIImage(imageLiteralResourceName: "inicio")
        tabBarController.tabBar.items?[1].image = UIImage(imageLiteralResourceName: "usuariosUnselected")
        tabBarController.tabBar.items?[1].selectedImage = UIImage(imageLiteralResourceName: "usuarios")
        tabBarController.tabBar.items?[2].image = UIImage(imageLiteralResourceName: "ajustesUnselected")
        tabBarController.tabBar.items?[2].selectedImage = UIImage(imageLiteralResourceName: "ajustes")
        
        

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    override func finish() {}
}
