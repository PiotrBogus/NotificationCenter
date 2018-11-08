
import UIKit

internal protocol NotificationPresenterDelegate: class {
    
    func didFinishDisplayingNotification()
}

internal final class NotificationDefaultViewPresenter {
    
    private struct Constants {
        
        static let animationDuration: TimeInterval = TimeInterval(0.25)
    }
    
    weak var delegate: NotificationPresenterDelegate?
    
    private var notificationDefaultView: NotificationDefaultView?
    
    init(delegate: NotificationPresenterDelegate) {
        self.delegate = delegate
    }
    
    func presentDefaultNotificationView(withParameters parameters: NotificationParameters) {
        DispatchQueue.main.async {
            self.notificationDefaultView = NotificationDefaultView(withParameters: parameters)
            self.show(parameters.hideDelay)
        }
    }
    
    private func show(_ hideDelay: TimeInterval) {
        guard let notificationDefaultView = notificationDefaultView else {
                return
        }
        
        let animationBlock = {
            notificationDefaultView.alpha = 1.0
        }
        
        UIView.animate(withDuration: Constants.animationDuration,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: animationBlock) { completed in
                        self.scheduleHide(hideDelay)
        }
    }
    
    private func scheduleHide(_ hideDelay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + hideDelay) { [weak self] in
            self?.hide()
        }
    }
    
    private func hide() {
        guard let notificationDefaultView = notificationDefaultView else { return }

        UIView.animate(withDuration: Constants.animationDuration, delay: 0, options: .curveEaseIn, animations: {
            notificationDefaultView.alpha = 0.0
        }) { _ in
            self.removeNotificationDefaultView()
        }
    }
    
    private func removeNotificationDefaultView() {
        notificationDefaultView?.removeFromSuperview()
        notificationDefaultView = nil
        delegate?.didFinishDisplayingNotification()
    }
}
