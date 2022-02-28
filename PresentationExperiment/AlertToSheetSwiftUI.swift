import SwiftUI
import Combine

@MainActor
struct AlertToSheetSwiftUI: View {
    @StateObject private var state: ViewState = .init()
    
    var body: some View {
        Button("Start") {
            Task {
                await state.startOperation()
            }
        }
        .alert("Operating...", isPresented: $state.isOperating, actions: {
            Button("Cancel") {  }
        })
        .sheet(isPresented: $state.isCompleted, onDismiss: nil) {
            Text("Completed")
        }
    }
}
