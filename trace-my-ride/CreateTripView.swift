//
//  CreateTripView.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/21/21.
//

import SwiftUI

struct CreateTripView: View {
    @EnvironmentObject var user: AuthUser
    
    @State var tripName: String = ""
    @State var description: String = ""
    @State var submitError: Bool = false
    @State var submissionComplete: Bool = false
    
    @Binding var showNewTripFlow: Bool
    
    func createTrip() {
        WebService().createTrip(name: tripName, description: description, token: user.token) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let createTripResponse):
                    guard let decodedResponse = try? JSONDecoder().decode(TripObject.self, from: createTripResponse) else { return }

                    self.user.trips?.append(decodedResponse)
                    
                    print("self.user.username: \(self.user.username)")
                    print("self.user.trips[0]: \(String(describing: self.user.trips?[0].name))")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                self.showNewTripFlow = false
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                TextField("Trip name", text: $tripName)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(4)

                TextField("Description", text: $description)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(4)

                Button(action: {
                    print("checking")
                    if tripName == "" || description == "" {
                        submitError = true
                    } else {
                        submitError = false
                        createTrip()
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
            .padding(.top, 20)
            
            Spacer()
        }
        .navigationTitle("Create a Trip")
    }
}

struct CreateTripView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTripView(showNewTripFlow: .constant(true))
    }
}
