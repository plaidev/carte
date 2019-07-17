//
//  AppDelegate.swift
//  CARTE
//
//  Created by tomoki.koga on 2019/04/27.
//  Copyright © 2019 PLAID, inc. All rights reserved.
//

import UIKit
import UserNotifications
import AdSupport
import RxSwift
import Firebase
import FirebaseAuth
import Crossroad
import KarteTracker

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router = DefaultRouter(scheme: "carte")
    var interactor: ApplicationInteractor?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configure()
        FirebaseApp.configure()
        configureKarteTracker()
        configureNotification(application: application)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let _ = Auth.auth().currentUser {
            window?.rootViewController = TabModuleInitializer().build()
        } else {
            window?.rootViewController = navi(SignInModuleInitializer().build())
        }
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        switch application.applicationState {
        case .active, .inactive:
            if KarteRemoteNotificationHandler.canHandleRemoteNotification(userInfo) {
                KarteRemoteNotificationHandler.handleRemoteNotification(userInfo)
            }
        case .background:
            break
        @unknown default:
            break
        }
        completionHandler(.newData)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        KarteUrlSchemeHandler.handle(url)
        return router.openIfPossible(url, options: options)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            return true
        }
        guard var components = userActivity.webpageURL.flatMap({ URLComponents(url: $0, resolvingAgainstBaseURL: true) }) else {
            return true
        }
        
        components.scheme = "carte"
        guard let url = components.url else {
            return true
        }
        
        return router.openIfPossible(url, options: [:])
    }
}

extension AppDelegate {
    
    private func configureNotification(application: UIApplication) {
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        
        application.registerForRemoteNotifications()
    }
    
    private func configureKarteTracker() {
        KarteTracker.setup(appKey: Configuration.applicationKey, config: KarteTrackerConfig.configure { (builder) in
            builder.idfaDelegate = self
            builder.isEnabledVisualTracking = true
        })
        
        interactor = ApplicationInteractor(userRepository: UserFirestoreRepository())
        interactor?.signOutIfNeeded()
        interactor?.trackIdentify()
        
        KarteVariables.fetch()
    }
    
    private func configure() {
        AppearanceConfigurator.configure()
        configureRouting()
    }
    
    private func configureRouting() {
        let baseURL = Configuration.deeplinkBaseURL
        router.register([
            ("\(baseURL)", { context in
                self.presentTabViewController(tab: .home(nil))
                return true
            }),
            ("\(baseURL)/favorite", { context in
                self.presentTabViewController(tab: .favorite)
                return true
            }),
            ("\(baseURL)/mypage", { context in
                self.presentTabViewController(tab: .mypage)
                return true
            }),
            ("\(baseURL)/cart", { context in
                self.presentTabViewController(tab: .home(.cart))
                return true
            }),
            ("\(baseURL)/search", { context in
                guard let q = context.parameter(for: "q") as String? else {
                    return false
                }
                self.presentTabViewController(tab: .home(.search(q)))
                return true
            }),
            ("\(baseURL)/item/:itemId", { context in
                let id: String = try! context.argument(for: "itemId")
                self.presentTabViewController(tab: .home(.item(ItemId(id: id))))
                return true
            })
        ])
    }
    
    private func presentTabViewController(tab: Tab) {
        let viewController = TabModuleInitializer(tab: tab).build()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if KarteRemoteNotificationHandler.canHandleRemoteNotification(userInfo) {
            KarteRemoteNotificationHandler.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        KarteTracker.shared.registerFCMToken(fcmToken)
    }
}

extension AppDelegate: KarteIDFADelegate {
    
    func isAdvertisingTrackingEnabled() -> Bool {
        return ASIdentifierManager.shared().isAdvertisingTrackingEnabled
    }
    
    func advertisingIdentifierString() -> String? {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
}
