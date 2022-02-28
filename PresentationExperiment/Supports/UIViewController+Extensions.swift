import UIKit

extension UIViewController {
    public func reserveToPresent(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard presentedViewController == nil else {
            DispatchQueue.main.async { [weak self] in
                self?.reserveToPresent(viewController, animated: animated, completion: completion)
            }
            return
        }
        present(viewController, animated: animated, completion: completion)
    }
}
