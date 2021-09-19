//
//  MainView.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/18/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Text("Welcome Back, Emilio")
                    .font(.system(size: 30))
                    .fontWeight(.semibold)
                    .padding(.leading, 16)
                    .padding(.bottom, 20)
                
                HStack {
                    Spacer()
                    
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 110, height: 110)

                            Image(systemName: "person.fill")
                                .resizable()
                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.7803921569, blue: 0.7450980392, alpha: 1)).opacity(0.9))
                                .frame(width: 50, height: 50)
                        }
                    }
                    .frame(width: 170, height: 170)
                    .background(Color(#colorLiteral(red: 0, green: 0.7803921569, blue: 0.7450980392, alpha: 1)))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 30, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 12)

                    Spacer()
                    
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 110, height: 110)

                            Image(systemName: "map.fill")
                                .resizable()
                                .foregroundColor(Color.blue.opacity(0.9))
                                .frame(width: 50, height: 50)
                        }
                    }
                    .frame(width: 170, height: 170)
                    .background(Color.blue.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 30, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 12)
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 110, height: 110)

                            Image(systemName: "gear")
                                .resizable()
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)))
                                .frame(width: 50, height: 50)
                        }
                    }
                    .frame(width: 170, height: 170)
                    .background(Color(#colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 30, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 12)

                    Spacer()
                    
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 110, height: 110)

                            Image(systemName: "plus")
                                .resizable()
                                .foregroundColor(Color(.systemGreen))
                                .frame(width: 50, height: 50)
                        }
                    }
                    .frame(width: 170, height: 170)
                    .background(Color(.systemGreen).opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 30, x: 0, y: 12)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 12)
                    
                    Spacer()
                }
                .padding(.top)
                
                Spacer()
            }
//            .padding(.top)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// padding(.top, -90)