import SwiftUI
import UIKit
import Combine

struct AlertToSheetUIKit: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

@MainActor
private final class ViewController: UIViewController {
    private let state: ViewState = .init()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button: UIButton = .init(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.addAction(.init { [weak self] _ in
            guard let self = self else { return }
            Task {
                await self.state.startOperation()
            }
        }, for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        state.publisher(for: \.isOperating)
            .sink { [weak self] isCompleted in
                guard let self = self else { return }
                if isCompleted {
                    let alertController: UIAlertController = .init(title: "Operating...", message: nil, preferredStyle: .alert)
                    self.reserveToPresent(alertController, animated: true, completion: nil)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            .store(in: &cancellables)

        state.publisher(for: \.isCompleted)
            .sink { [weak self] isCompleted in
                guard let self = self else { return }
                if isCompleted {
                    let sheetViewController = UIHostingController(rootView: Text("Completed"))
                    sheetViewController.presentationController?.delegate = self
                    self.reserveToPresent(sheetViewController, animated: true, completion: nil)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            .store(in: &cancellables)
    }
}

extension ViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        state.isCompleted = false
    }
}
