//
//  RandomUsersTests.swift
//  RandomUsersTests
//
//  Created by Elliot Hannah III on 4/3/23.
//

import XCTest
@testable import RandomUsers

final class RandomUsersTests: XCTestCase {

    private func getTestJSONData() -> Data {
        guard let path = Bundle.main.path(forResource: "randomUsers", ofType: "json") else {
            fatalError("randomUsers.json file not found")
        }
        
        let internalURL = URL(filePath: path)
        return try! Data(contentsOf: internalURL)
    }
    
    //tests decoding the sample data into a Response
    func testUserModel() throws {
        let jsonData = getTestJSONData()
        do {
            _ = try JSONDecoder().decode(Response.self, from: jsonData)
        }
        catch {
            XCTFail("Failed to decode JSON into the model: \(error)")
        }
    }

}
