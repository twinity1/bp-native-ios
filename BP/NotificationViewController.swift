//
//  NotificationViewController.swift
//  BP
//
//  Created by Aleš Kůtek on 04.02.2021.
//

import Foundation
import UIKit
import UserNotifications

class NotificationViewController : UIViewController {
    override func viewDidLoad() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            self.sendNotification()
        }
        
        sendNotification()
    }
    
    func sendNotification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Test!"
        content.body = "Body of the message."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
