
import Foundation

internal final class Notification {
    
    let priority: NotificationPriority
    let creationDate: Date = Date()
    let parameters: NotificationParameters
    var notificationHasBeenShown: Bool = false
    
    init(priority: NotificationPriority = .normal, parameters: NotificationParameters) {
        self.priority = priority
        self.parameters = parameters
    }
}
