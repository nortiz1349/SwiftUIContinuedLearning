//
//  LocalNotificationBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Nortiz M1 on 2022/10/14.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
	
	static let instance = NotificationManager() // Singleton
	
	func requestAuthorization() {
		let options: UNAuthorizationOptions = [.alert, .sound, .badge]
		UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
			if let error = error {
				print("ERROR: \(error.localizedDescription)")
			} else {
				print("SUCCESS")
			}
		}
	}
	
	func scheduleNotification() {
		
		let content = UNMutableNotificationContent()
		content.title = "This is my first notification"
		content.subtitle = "This is subtitle."
		content.sound = .default
		content.badge = 1
		
		// time
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
		// caleder
//		var dateComponents = DateComponents()
//		dateComponents.hour = 12
//		dateComponents.minute = 35
//		dateComponents.weekday = 6 // friday
//		let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
		
		// location ⭐️
//		let coordinates = CLLocationCoordinate2D(
//			latitude: 40.00,
//			longitude: 50.00)
//		let region = CLCircularRegion(
//			center: coordinates,
//			radius: 100,
//			identifier: UUID().uuidString)
//		region.notifyOnEntry = true
//		region.notifyOnExit = false
//		let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
		// - end
		 
		let request = UNNotificationRequest(
			identifier: UUID().uuidString,
			content: content,
			trigger: trigger)
		UNUserNotificationCenter.current().add(request)
	}
	
	func cancelNotification() {
		UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
		UNUserNotificationCenter.current().removeAllDeliveredNotifications()
	}
	
}

struct LocalNotificationBootcamp: View {
    var body: some View {
		VStack(spacing: 40.0) {
			Button("Request Permission") {
				NotificationManager.instance.requestAuthorization()
			}
			Button("Schedule Notification") {
				NotificationManager.instance.scheduleNotification()
			}
			Button("Cancel Notification") {
				NotificationManager.instance.cancelNotification()
			}
			Button("Clear Badge Number") {
				UIApplication.shared.applicationIconBadgeNumber = 0
			}
		}
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
