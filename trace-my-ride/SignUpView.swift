//
//  SignUpView.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/14/21.
//

import SwiftUI

struct SignUpView: View {
    @Binding var isPresented: Bool
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var trackingId = ""
    
    @State var submitError: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(4)

                    TextField("Email Address", text: $email)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(4)
                        
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(4)
                    
                    TextField("Tracking ID", text: $trackingId)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(4)
                    
                    Button(action: {
                        print("checking")
                        if username == "" || email == "" || password == "" || trackingId == "" {
                            submitError = true
                        } else {
                            submitError = false
                            isPresented = false
                        }
                    }, label: {
                        Text("Submit")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(4)
                    })
                    
                    if submitError {
                        Text("All fields must be filled out.")
                            .foregroundColor(.red)
                            .padding(.top, 5)
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Sign Up")
        }
    }
}
