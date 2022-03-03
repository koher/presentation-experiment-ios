import SwiftUI

struct ActivityIndicatorByChild: View {
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
    @State private var presentsActivityIndicator: Bool = false
    
    var body: some View {
        Button("Present") {
            presentsActivityIndicator = true
            Task {
                try await Task.sleep(nanoseconds: 2_000_000_000)
                presentsActivityIndicator = false
            }
        }
        .activityIndicatorCover(isPresented: presentsActivityIndicator)
    }
}
