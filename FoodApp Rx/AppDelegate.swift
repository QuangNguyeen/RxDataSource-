//
//  AppDelegate.swift
//  FoodApp Rx
//
//  Created by Quang Nguyen on 5/11/21.
//

import UIKit
import RxSwift
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    private let bag = DisposeBag()
    private let userService = UserService()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        userService.loadRecipes()
            .map { [unowned self] in
                self.getRootViewController(withRecipes: $0)
            }
            .subscribe(onNext: {[unowned self] in
                self.setWindow($0)
            })
            .disposed(by: bag)
        
        return true
    }
    
    private func setWindow(_ vc: UIViewController) {
        window = UIWindow()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    private func getRootViewController(withRecipes recipes: [Recipe]) -> UIViewController {
        
        var vc = RecipeListViewController()
        vc.bind(to: RecipeListViewModel(withRecipes: recipes))
        
        return UINavigationController(rootViewController: vc)
    }
}

