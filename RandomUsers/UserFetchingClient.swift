//
//  UserFetchingClient.swift
//  RandomUsers
//
//  Created by Elliot Hannah III on 4/3/23.
//

import Foundation

struct UserFetchingClient {
    static private let url = URL(string: "https://randomuser.me/api/?results=10&format=pretty")!
    
    static func getUsers() async throws -> [User] {
        async let (data, _) = URLSession.shared.data(from: url)
        
        //returns an array of User instances by using a JSONDecoder to decode the Data into a Response
        let response = try await JSONDecoder().decode(Response.self, from: data)
        return response.users
    }
}
