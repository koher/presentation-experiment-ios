import SwiftUI

struct AlertByChild: View {
    var body: some View {
        VStack(spacing: 20) {
            Child()
            Child()
        }
        .padding()
    }
}

@MainActor
private struct Child: View {
    @State private var presentsAlert: Bool = false
    
    var body: some View {
        Button("Present") {
            presentsAlert = true
            Task {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                presentsAlert = false
            }
        }
        .alert("Alert", isPresented: $presentsAlert, actions: { EmptyView() })
    }
}
