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
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Spacer()
                            
                            VStack {
                                Text("MAP")
                                    .font(.title2).bold()
                                    .foregroundColor(.white)
                                    .shadow(radius: 10)
                            }
                            .frame(width: 175, height: 180)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .shadow(color: Color.blue.opacity(0.3), radius: 30, x: 0, y: 20)
                            .shadow(color: Color.blue.opacity(0.2), radius: 10, x: 0, y: 6)
                            
                            Spacer()
                            
                            VStack (alignment: .leading) {
                                Text("DISTANCE").foregroundColor(.white).font(.system(size: 23.0)).fontWeight(.bold)
                                HStack {
                                    Text("234").foregroundColor(.white).font(.system(size: 40.0)).bold()
                                    Text("MI").foregroundColor(.white).font(.system(size: 23.0)).fontWeight(.heavy).baselineOffset(10.0)
                                }
                            }
                            .frame(width: 175, height: 180)
                            .background(Color.blue)
                            .cornerRadius(20)
                            .shadow(color: Color.blue.opacity(0.3), radius: 30, x: 0, y: 20)
                            .shadow(color: Color.blue.opacity(0.2), radius: 10, x: 0, y: 6)
                            
                            Spacer()
                        }
                        .padding(.bottom, 6)
                        
                        VStack {
                            Text("Main Tracking View")
                                .font(.title).bold()
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                        }
                        .frame(width: 360, height: 200)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .shadow(color: Color.blue.opacity(0.3), radius: 30, x: 0, y: 20)
                        .shadow(color: Color.blue.opacity(0.2), radius: 10, x: 0, y: 6)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                        
                        Spacer()
                    }
                }.padding(.bottom, 5)
            }
        }
        .navigationBarTitle(Text("\(user.username)"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "gear")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MainTrackingView_Previews: PreviewProvider {
    static var myEnvObject = AuthUser()
    static var previews: some View {
        MainTrackingView()
            .environmentObject(myEnvObject)
    }
}
