//
//  AppDelegate.swift
//  eShop
//
//  Created by 08APO0516 on 28/04/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import CocoaLumberjack
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {

        #if DEBUG
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-DEBUG", ofType: "plist") ?? ""
        guard let fileopts = FirebaseOptions(contentsOfFile: filePath)
            else { assert(false, "Couldn't load config file"); return }
        FirebaseApp.configure(options: fileopts)
        #else
        if NSClassFromString("XCTest") == nil {
            let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") ?? ""
            guard let fileopts = FirebaseOptions(contentsOfFile: filePath)
                else { assert(false, "Couldn't load config file"); return }
            FirebaseApp.configure(options: fileopts)
        }
        #endif

    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setupNotifications(application)

        StartUpAppSequencer.shared.start()

        return true
    }

    // MARK: - Private/Internal

    fileprivate func setupNotifications(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().delegate = self

        Messaging.messaging().delegate = self

        if #available(iOS 10, *) {

            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { _, _ in }

            let snoozeAction = UNNotificationAction(
                identifier: "snooze.action",
                title: "Snooze",
                options: [])
            let brewAction = UNNotificationAction(
                identifier: "brew.action",
                title: "Brew",
                options: [])
            let snoozeCategory = UNNotificationCategory(
                identifier: "iMug.category",
                actions: [snoozeAction,brewAction],
                intentIdentifiers: [],
                options: [])
            UNUserNotificationCenter.current().setNotificationCategories([snoozeCategory])

        } else { // iOS 9 support
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        }
        application.registerForRemoteNotifications()
    }

}

extension AppDelegate : MessagingDelegate {
    // Receive data message on iOS 10 devices.
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print("%@", remoteMessage.appData)
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
        print("Firebase registration token: \(fcmToken)")
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    /*
     /// * Subscribing to any topics.
     - (void)messaging:(FIRMessaging *)messaging
     didReceiveRegistrationToken:(NSString *)fcmToken
     NS_SWIFT_NAME(messaging(_:didReceiveRegistrationToken:));

     /// This method is called on iOS 10 devices to handle data messages received via FCM through its
     /// direct channel (not via APNS). For iOS 9 and below, the FCM data message is delivered via the
     /// UIApplicationDelegate's -application:didReceiveRemoteNotification: method.
     - (void)messaging:(FIRMessaging *)messaging
     didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage
     NS_SWIFT_NAME(messaging(_:didReceive:))
     __IOS_AVAILABLE(10.0);


     */
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // MARK: - Push Notifications methods
    /// Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        // CampaignManager.shared.application(application:application, deviceToken: deviceToken)
        Messaging.messaging().apnsToken = deviceToken

        let deviceTokenString = deviceToken.reduce("") { $0 + String(format: "%02X", $1) }

        print("📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩")
        print("APNs device token: \(deviceTokenString)")
        print("📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩")

        let token = Messaging.messaging().fcmToken
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
        print("FCM token: \(token ?? "")")
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")

        // Persist it in your backend in case it's new
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

        // CampaignManager.shared.application(application:application, error: error)

        print("❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌")
        print("didFailToRegisterForRemoteNotificationsWithError: \(error)")
        print("📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩📩")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("todo from background")
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {

        print("application ")
    }

    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Play sound and show alert to the user

        print("normal-foreground notification-triggered")
        print("\(notification.request.content.userInfo)")
        /*
         guard let _pushNotification = PushNotification(dictionary: notification.request.content.userInfo as! JSONDictionary) else {
         return
         }
         print("\(_pushNotification)")
         */
        completionHandler([.alert,.sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo
        print("normal-user-pressed")
        /*
         guard let _pushNotification = PushNotification(dictionary: userInfo as! JSONDictionary) else {
         return
         }
         print("\(_pushNotification)")
         */

        if response.actionIdentifier == "snooze.action" {
            print("snooze action")
        }
        if response.actionIdentifier ==  "brew.action" {
            //Do something else...
            print("brew action")
        }
        completionHandler()
    }

}
