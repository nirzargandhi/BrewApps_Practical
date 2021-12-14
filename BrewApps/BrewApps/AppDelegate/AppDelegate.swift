//
//  AppDelegate.swift
//  BrewApps
//
//  Created by Nirzar Gandhi on 14/12/21.
//

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Variable Declaration
    var window: UIWindow?
    var navhomeViewController : UINavigationController?
    
    //MARK: - AppDelegate Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //IQKeyboard Integration
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        //Set Root ViewController Integration
        Utility().setRootWelcomeVC()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        UIPasteboard.general.items = [[String: Any]()]
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

