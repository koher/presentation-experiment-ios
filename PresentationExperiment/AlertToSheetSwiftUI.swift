import SwiftUI
import Combine

@MainActor
struct AlertToSheetSwiftUI: View {
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
        .alert("Operating...", isPresented: $state.isOperating, actions: {
            Button("Cancel") {  }
        })
        .sheet(isPresented: $state.isCompleted, onDismiss: nil) {
            Text("Completed")
        }
        .navigationTitle(String(reflecting: Self.self))
        .navigationBarTitleDisplayMode(.inline)
    }
}
