//
//  ContentView.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/14/21.
//

import SwiftUI

struct ContentView: View {
    @State var email = ""
    @State var password = ""
    @State var isAuthenticated: Bool = false
    
    @State var showSignUp: Bool = false
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        WebService().login(email: email, password: password) { result in
            switch result {
            case .success(let loginResponse):
                guard let decodedResponse = try? JSONDecoder().decode(LoginResponse.self, from: loginResponse) else { return }
                
                defaults.setValue(decodedResponse.username, forKey: "username")
                defaults.setValue(decodedResponse.email, forKey: "email")
                defaults.setValue(decodedResponse.password, forKey: "password")
                defaults.setValue(decodedResponse.trackingId, forKey: "trackingId")
                defaults.setValue(decodedResponse.token, forKey: "token")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                VStack {
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(4)
                        .autocapitalization(.none)
                        
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(4)
                    
                    Button(action: {
                        login()
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(4)
                    }).padding()
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.black)
                        Button(action: {
                            self.showSignUp = true
                        }, label: {
                            Text("Sign Up")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        })
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Sign In")
            .sheet(isPresented: $showSignUp) {
                SignUpView(isPresented: $showSignUp)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
