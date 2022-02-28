import SwiftUI

extension View {
    public func activityIndicatorCover(isPresented: Bool) -> some View {
        modifier(ActivityIndicatorCoverModifier(isPresented: isPresented))
    }
}

private struct ActivityIndicatorCoverModifier: ViewModifier {
    let isPresented: Bool

    func body(content: Content) -> some View {
        ActivityIndicatorCoverView(isPresented: isPresented, content: content)
            .ignoresSafeArea()
    }
}

private struct ActivityIndicatorCoverView<Content: View>: UIViewControllerRepresentable {
    let isPresented: Bool
    let content: Content
    
    func makeUIViewController(context: Context) -> UIHostingController<Content> {
        UIHostingController<Content>(rootView: content)
    }
    
    func updateUIViewController(_ viewController: UIHostingController<Content>, context: Context) {
        if isPresented {
            guard viewController.presentedViewController == nil else { return }
            
            let indicatorViewController: ActivityIndicatorCoverViewController = .init()
            indicatorViewController.modalPresentationStyle = .overFullScreen
            indicatorViewController.modalTransitionStyle = .crossDissolve
            
            context.coordinator.presentedViewController = indicatorViewController
            viewController.present(indicatorViewController, animated: true, completion: nil)
        } else {
            guard let indicatorViewController = viewController.presentedViewController, indicatorViewController === context.coordinator.presentedViewController else { return }
            viewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator {
        fileprivate var presentedViewController: UIViewController?
    }
}

@MainActor
private final class ActivityIndicatorCoverViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified: return .black
            case .dark: return .white
            default: return .black
            }
        }
        .withAlphaComponent((1.0 - 182.0 / 255.0)) // この透過率は標準のモーダルと同じ比率を計算したもの
        
        let baseView: UIView = .init()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .systemBackground
        baseView.layer.cornerRadius = 8
        baseView.layer.cornerCurve = .continuous
        view.addSubview(baseView)
        
        let indicatorView: UIActivityIndicatorView = .init(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.startAnimating()
        baseView.addSubview(indicatorView)
        
        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            baseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            baseView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: padding),
            indicatorView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: padding),
            baseView.trailingAnchor.constraint(equalTo: indicatorView.trailingAnchor, constant: padding),
            baseView.bottomAnchor.constraint(equalTo: indicatorView.bottomAnchor, constant: padding),
        ])
    }
}
