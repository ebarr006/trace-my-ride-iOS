//
//  ContentView.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/14/21.
//

import SwiftUI

class AuthUser: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var token: String = ""
}

struct ContentView: View {
    @State var isAuthenticated: Bool = false
    @StateObject var user = AuthUser()

    var body: some View {
        NavigationView {
            LoginView(isAuthenticated: self.$isAuthenticated)
                .navigationTitle("Sign In")
        }
        .environmentObject(user)
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
    @State var showRegisterView: Bool = false
    @State var submitError: Bool = false

    @Binding var isAuthenticated: Bool
    
    @EnvironmentObject var user: AuthUser
    
    func login() {
        WebService().login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loginResponse):
                    guard let decodedResponse = try? JSONDecoder().decode(LoginResponse.self, from: loginResponse) else { return }
                    self.user.username = decodedResponse.username ?? String("")
                    self.user.email = decodedResponse.email ?? String("")
                    self.user.token = decodedResponse.token ?? String("")

                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func register() {
        WebService().register(username: username, email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let registerResponse):
                    guard let decodedResponse = try? JSONDecoder().decode(RegisterResponse.self, from: registerResponse) else { return }

                    self.user.username = decodedResponse.username ?? String("")
                    self.user.email = decodedResponse.email ?? String("")
                    self.user.token = decodedResponse.token ?? String("")
                    
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
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
                
                NavigationLink(destination: MainTrackingView()
                .navigationBarBackButtonHidden(true), isActive: self.$isAuthenticated) { EmptyView() }
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
                        
                        Button(action: {
                            print("checking")
                            if username == "" || email == "" || password == "" {
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
                        .padding(.top, 10)
                        
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
}
