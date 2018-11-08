
import Foundation

internal struct NotificationParameters {
    
    var message: String
    var hideDelay: TimeInterval
    var verticalAlignment: NotificationVerticalAlignment
    
    init(message: String, hideDelay: TimeInterval = 3, verticalAlignment: NotificationVerticalAlignment = .center) {
        self.message = message
        self.hideDelay = hideDelay
        self.verticalAlignment = verticalAlignment
    }
}
