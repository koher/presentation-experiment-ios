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
                    ActivityIndicatorToSheetSwiftUI()
                } label: {
                    Text("ActivityIndicator -> Sheet (SwiftUI)")
                }
                
                NavigationLink {
                    ActivityIndicatorToSheetUIKit()
                } label: {
                    Text("ActivityIndicator -> Sheet (UIKit)")
                }
                
                NavigationLink {
                    AlertToSheetSwiftUI()
                } label: {
                    Text("Alert -> Sheet (SwiftUI)")
                }
                
                NavigationLink {
                    AlertToSheetUIKit()
                } label: {
                    Text("Alert -> Sheet (UIKit)")
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
