//
//  SOLID.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 05.10.2024.
//

import Foundation

// MARK: - S - Single Responsibility Principle

//class UserManager {
//    func saveUser(user: String) {
//        print("User saved: \(user)")
//        logUserSave(user: user)
//    }
//
//    func logUserSave(user: String) {
//        print("Log: User saved: \(user)")
//    }
//}

class UserManager {
    let logger = Logger()

    func saveUser(user: String) {
        print("User saved: \(user)")
        logger.log("User saved: \(user)")
    }
}

class Logger {
    func log(_ message: String) {
        print("Log: \(message)")
    }
}

// MARK: - O - Open/Closed Principle

//class DiscountManager {
//    func applyDiscount(amount: Double, discountType: String) -> Double {
//        if discountType == "percentage" {
//            return amount * 0.9
//        } else if discountType == "flat" {
//            return amount - 10
//        }
//        return amount
//    }
//}

protocol Discount {
    func apply(to amount: Double) -> Double
}

class PercentageDiscount: Discount {
    func apply(to amount: Double) -> Double {
        return amount * 0.9
    }
}

class FlatDiscount: Discount {
    func apply(to amount: Double) -> Double {
        return amount - 10
    }
}

class DiscountManager {
    func applyDiscount(amount: Double, discount: Discount) -> Double {
        return discount.apply(to: amount)
    }
}

class NoDiscount: Discount {
    func apply(to amount: Double) -> Double {
        return amount
    }
}

// MARK: - L - Liskov Substitution Principle

//class Bird {
//    func fly() {
//        print("Bird is flying")
//    }
//}
//
//class Penguin: Bird {
//    override func fly() {
//        fatalError("Penguins can't fly!")
//    }
//}

class Bird {}

class FlyingBird: Bird {
    func fly() {
        print("Bird is flying")
    }
}

class Penguin: Bird {
    // Doesn't have fly method
}

// MARK: - I - Interface Segregation Principle

//protocol Worker {
//    func work()
//    func attendMeetings()
//}
//
//class Developer: Worker {
//    func work() {
//        print("Developer is coding")
//    }
//
//    func attendMeetings() {
//        print("Developer attending meeting")
//    }
//}
//
//class Designer: Worker {
//    func work() {
//        print("Designer is designing")
//    }
//
//    func attendMeetings() {
//        // ?
//    }
//}

protocol Workable {
    func work()
}

protocol MeetingAttendable {
    func attendMeetings()
}

class Developer: Workable, MeetingAttendable {
    func work() {
        print("Developer is coding")
    }

    func attendMeetings() {
        print("Developer attending meeting")
    }
}

class Designer: Workable {
    func work() {
        print("Designer is designing")
    }
}

// MARK: - D - Dependency Inversion Principle

//class EmailService {
//    func sendEmail(message: String) {
//        print("Sending email: \(message)")
//    }
//}
//
//class NotificationManager {
//    let emailService = EmailService()
//
//    func sendNotification(message: String) {
//        emailService.sendEmail(message: message)
//    }
//}

protocol NotificationService {
    func send(message: String)
}

class EmailService: NotificationService {
    func send(message: String) {
        print("Sending email: \(message)")
    }
}

class SMSService: NotificationService {
    func send(message: String) {
        print("Sending SMS: \(message)")
    }
}

class NotificationManager {
    let service: NotificationService

    init(service: NotificationService) {
        self.service = service
    }

    func sendNotification(message: String) {
        service.send(message: message)
    }
}
