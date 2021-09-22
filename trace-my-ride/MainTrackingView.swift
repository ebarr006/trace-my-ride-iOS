//
//  MainTrackingView.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/15/21.
//

import SwiftUI

struct MainTrackingView: View {
    @EnvironmentObject var user: AuthUser
    
    @State var tripName: String = ""
    @State var description: String = ""
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        IconTextPair(symbol: "person.fill", symbolSize: 15, circleSize: 30, TODO_stat: "\(self.user.username)", leftAlign: true)
                        IconTextPair(symbol: "map.fill", symbolSize: 15, circleSize: 30, TODO_stat: "\((self.user.trips?[0].name)!)", leftAlign: true)
                        IconTextPair(symbol: "arrow.triangle.swap", symbolSize: 15, circleSize: 30, TODO_stat: "\((self.user.trips?[0].mileage)!) miles", leftAlign: true)
                        IconTextPair(symbol: "pin.fill", symbolSize: 15, circleSize: 30, TODO_stat: "\((self.user.trips?[0].pinCount)!)" + " pins", leftAlign: true)
                    }
                    .frame(width: 210, height: 220)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .shadow(color: Color.blue.opacity(0.3), radius: 30, x: 0, y: 20)
                    .shadow(color: Color.blue.opacity(0.2), radius: 10, x: 0, y: 6)
                    
                    Spacer()
                        
                    VStack {
                        Text("Placeholder")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(width: 140, height: 220)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .shadow(color: Color.blue.opacity(0.3), radius: 30, x: 0, y: 20)
                    .shadow(color: Color.blue.opacity(0.2), radius: 10, x: 0, y: 6)
                    
                    Spacer()
                }
                .padding(.bottom, 6)
                
                VStack {
                    Text("PLACEHOLDER")
                        .font(.title).bold()
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                }
                .frame(width: 360, height: 200)
                .background(Color.blue)
                .cornerRadius(20)
                .shadow(color: Color.blue.opacity(0.3), radius: 30, x: 0, y: 24)
                .shadow(color: Color.blue.opacity(0.2), radius: 20, x: 0, y: 6)
                .padding(.leading, 5)
                .padding(.trailing, 5)
                
                Spacer()
                
                HStack {
                    Button(action: { print("stop") }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 70, height: 70)
                            .shadow(color: Color.red.opacity(0.3), radius: 8, x: 0, y: 5)
                            .shadow(color: Color.red.opacity(0.1), radius: 8, x: 0, y: 5)
                    }.padding()
                    Button(action: { print("start") }) {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .foregroundColor(.green)
                            .frame(width: 70, height: 70)
                            .shadow(color: Color.green.opacity(0.3), radius: 8, x: 0, y: 5)
                            .shadow(color: Color.green.opacity(0.1), radius: 8, x: 0, y: 5)
                    }
                }
            }
        }
        .padding(.bottom, 5)
        .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
    }
}

struct MainTrackingView_Previews: PreviewProvider {
    static var myEnvObject = AuthUser()
    static var previews: some View {
        MainTrackingView()
            .environmentObject(myEnvObject)
    }
}

struct IconTextPair: View {
    var symbol: String
    var symbolSize: CGFloat
    var circleSize: CGFloat
    var TODO_stat: String
    var leftAlign: Bool
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: circleSize, height: circleSize)
                    .shadow(color: Color.black.opacity(0.8), radius: 10, x: 0, y: 4)
                    
                
                Image(systemName: symbol)
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: symbolSize, height: symbolSize)
            }
            .padding(.leading, 20)
            .padding(.trailing, 2)
            Text("\(TODO_stat)")
                .font(.body)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.8), radius: 10, x: 0, y: 4)
            if leftAlign {
                Spacer()
            }
        }
    }
}
