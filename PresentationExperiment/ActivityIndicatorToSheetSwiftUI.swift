import SwiftUI
import Combine

@MainActor
struct ActivityIndicatorToSheetSwiftUI: View {
    @StateObject private var state: OperationViewState = .init()
    
    var body: some View {
        ZStack {
            Color
                .green
                .ignoresSafeArea()
            Button("Start") {
                Task {
                    await state.startOperation()
                }
            }
        }
        .activityIndicatorCover(isPresented: state.isOperating)
        .sheet(isPresented: $state.isCompleted, onDismiss: nil) {
            Text("Completed")
        }
        .navigationTitle(String(reflecting: Self.self))
        .navigationBarTitleDisplayMode(.inline)
    }
}
