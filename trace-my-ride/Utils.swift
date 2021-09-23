//
//  Utils.swift
//  trace-my-ride
//
//  Created by Emilio Barreiro on 9/21/21.
//

import Foundation
import SwiftUI
import CoreLocation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct RegisterRequestBody: Codable {
    let username: String
    let email: String
    let password: String
}

struct CreateTripBody: Codable {
    let name: String
    let description: String
}

struct PinPacket: Codable {
    let tripId: String
    let lat: Double
    let lng: Double
}

class TripObject: Codable, ObservableObject {
    public var id: String?
    public var name: String?
    public var description: String?
    public var pinCount: Int?
    public var mileage: Int?
    public var startDate: String?
    public var endDate: String?
    public var active: Bool?
    public var userId: String?
}

class UserObject: Codable, ObservableObject {
    public let id: String?
    public let username: String?
    public let trips: [TripObject]?
    public let token: String?
}

class PinObject: Codable, ObservableObject {
    public let id: String
    public let date: String
    public let lat: String
    public let lng: String
    public let tripId: String
}
