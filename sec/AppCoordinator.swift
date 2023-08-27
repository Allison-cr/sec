import Foundation
import UIKit
import SwiftUI

// MARK: - AppCoordinator

class AppCoordinator {
    
    // MARK: - Properties
    
    private let window: UIWindow

    // MARK: - Initializers
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let splashScreen = SplashScreen()
        let hostingController = UIHostingController(rootView: splashScreen)

        window.rootViewController = hostingController
        window.makeKeyAndVisible()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showCharacterScreen()
        }
    }
    
    func showCharacterScreen() {
        let characterViewController = CharacterViewController()
        let navigationController = UINavigationController(rootViewController: characterViewController)
        window.rootViewController = navigationController
    }
    
    func showCharacterDetailScreen(for character: Character) {
        let characterDetailView = CharacterDetailView(character: character)
        let hostingController = UIHostingController(rootView: characterDetailView)
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(hostingController, animated: true)
        } else {
            let navigationController = UINavigationController(rootViewController: hostingController)
            window.rootViewController = navigationController
        }
    }
}
