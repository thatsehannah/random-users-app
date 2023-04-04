//
//  User.swift
//  RandomUsers
//
//  Created by Elliot Hannah III on 4/4/23.
//

import Foundation

struct Response: Decodable {
    let users: [User]
    
    //provides the foundation to point the JSON data "results" key to point to the
    //The case users must have a raw value of results to match the JSON
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}

struct User: Identifiable, Decodable {
    let id: String
    let name: Name
    
    var fullName: String {
        name.title + ". " + name.first + " " + name.last
    }
    
    init(from decoder: Decoder) throws {
        
        //assigns the name property to the value in the nested "name" key
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        
        //gets the value associated with uuid key in the nested LogInfoCodingKeys container
        //using the nestedContainer to access the uuid for the "login" key, we can assign the id of the User to the appropriate value
        let loginInfo = try values.nestedContainer(keyedBy: LoginInfoCodingKeys.self, forKey: .login)
        self.id = try loginInfo.decode(String.self, forKey: .uuid)
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case name //matches the "name" key of the JSON data
    }
    
    //Needed to used this because the uuid key is nested under the login key
    enum LoginInfoCodingKeys: String, CodingKey {
        case uuid
    }
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}
