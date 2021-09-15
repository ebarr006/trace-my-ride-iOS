//
//  MainTrackingView.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/15/21.
//

import SwiftUI

struct MainTrackingView: View {
    @EnvironmentObject var user: AuthUser

    var body: some View {
        NavigationView {
            VStack {
                Text("Main Tracking View")
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "gear")
                }
            }
        }
    }
}

struct MainTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        MainTrackingView()
    }
}
