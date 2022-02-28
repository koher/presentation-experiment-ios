//
//  ContentView.swift
//  PresentationExperiment
//
//  Created by Yuta Koshizawa on 2022/02/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    AlertToSheetSwiftUI()
                } label: {
                    Text("AlertToSheetSwiftUI")
                }
                
                NavigationLink {
                    AlertToSheetUIKit()
                } label: {
                    Text("AlertToSheetUIKit")
                }
                
                NavigationLink {
                    ActivityIndicatorToSheetSwiftUI()
                } label: {
                    Text("ActivityIndicatorToSheetSwiftUI")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
