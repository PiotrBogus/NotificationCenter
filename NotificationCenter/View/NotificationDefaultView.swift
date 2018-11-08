
import UIKit

internal final class NotificationDefaultView: UIView {
    
    private struct Constants {
        
        static let backgroundColor: UIColor = .black
        static let textColor: UIColor = .white
        static let textFont: UIFont = UIFont.systemFont(ofSize: 15)
        static let cornerRadius: CGFloat = 6
        static let padding: CGFloat = 9
        static let outerMargin: CGFloat = 8
        static let topOrBottomOffset: CGFloat = 30
        static let minWidth: CGFloat = 210
        static let minHeight: CGFloat = 60
    }
    
    private let titleLabel = UILabel(frame: CGRect.zero)
    
    init(withParameters parameters: NotificationParameters) {
        super.init(frame: CGRect.zero)

        setUp(withParameters: parameters)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setUp(withParameters parameters: NotificationParameters) {
        setUpViewsHierarchy()
        setUpTitleLabel()
        setText(parameters.message)
        setUpConstraints(withVerticalAlignment: parameters.verticalAlignment)
        alpha = 0.0
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        backgroundColor = Constants.backgroundColor
    }
    
    private func setUpViewsHierarchy() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        window.addSubview(self)
        addSubview(titleLabel)
    }
    
    private func setUpTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textColor = Constants.textColor
        titleLabel.font = Constants.textFont
        titleLabel.textAlignment = .center
    }
    
    private func setText(_ text: String) {
        titleLabel.text = text
    }
    
    private func setUpConstraints(withVerticalAlignment verticalAlignment: NotificationVerticalAlignment) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        setUpDefaultViewConstraints(withWindow: window, verticalAlignment: verticalAlignment)
        setUpTitleLabelConstraints()
    }
    
    private func setUpDefaultViewConstraints(withWindow window: UIWindow, verticalAlignment: NotificationVerticalAlignment) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [
            widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.minWidth),
            widthAnchor.constraint(lessThanOrEqualToConstant: window.frame.width - 2 * Constants.outerMargin),
            heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.minHeight),
            centerXAnchor.constraint(equalTo: window.centerXAnchor),
            ]
        
        switch verticalAlignment {
        case .top:
            constraints.append(topAnchor.constraint(equalTo: window.topAnchor, constant: Constants.topOrBottomOffset))
        case .center:
            constraints.append(centerYAnchor.constraint(equalTo: window.centerYAnchor))
        case .bottom:
            constraints.append(bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: Constants.topOrBottomOffset * -1))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setUpTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.padding * -1),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.padding * -1)
            ])
    }
}
