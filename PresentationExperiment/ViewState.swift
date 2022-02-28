import Combine

@MainActor
final class ViewState: ObservableObject {
    @Published private var operationState: OperationState = .waiting
    
    var isOperating: Bool {
        get {
            switch operationState {
            case .waiting, .completed: return false
            case .operating: return true
            }
        }
        set {
        }
    }
    
    var isCompleted: Bool {
        get {
            switch operationState {
            case .waiting, .operating: return false
            case .completed: return true
            }
        }
        set {
            guard case .completed = operationState else { return }
            if !newValue {
                operationState = .waiting
            }
        }
    }
    
    func startOperation() async {
        guard case .waiting = operationState else { return }
        operationState = .operating
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        operationState = .completed
    }
}

