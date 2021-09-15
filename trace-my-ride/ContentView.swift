//
//  ContentView.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/14/21.
//

import SwiftUI

struct ContentView: View {
    @State var isAuthenticated: Bool = false

    var body: some View {
        NavigationView {
            LoginView(isAuthenticated: self.$isAuthenticated)
                .navigationTitle("Sign In")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoginView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var trackingId: String = ""
    @State var showRegisterView: Bool = false
    @State var submitError: Bool = false

    @Binding var isAuthenticated: Bool
    
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
    
    func register() {
        let defaults = UserDefaults.standard
        WebService().register(username: username, email: email, password: password, trackingId: trackingId) { result in
            switch result {
            case .success(let registerResponse):
                guard let decodedResponse = try? JSONDecoder().decode(RegisterResponse.self, from: registerResponse) else { return }

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
//            print(defaults.dictionaryRepresentation())
        }
    }

    var body: some View {
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
                        self.submitError = false
                        self.showRegisterView.toggle()
                    }, label: {
                        Text("Sign Up")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    })
                }
            }
            .padding()
            
            Spacer()
        }
        .sheet(isPresented: self.$showRegisterView) {
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
                                self.showRegisterView = false
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
                }.navigationTitle("Sign Up")
        }
        }
    }
}
