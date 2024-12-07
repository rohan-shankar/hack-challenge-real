//
//  RideListing.swift
//  testingtesting123
//
//  Created by Rohan Shankar on 12/3/24.
//

struct RideListing {
    var id: Int
    var destination: String
    var date: String
    var gas_price: String
    var drivers: String
    var riders: [String]
    var userIsMember: Bool {
        riders.contains(RideListing.currentUserName!)
    }

    static var currentUserName: String?

    mutating func toggleMembership() {
        
        for rider in riders {
            print(rider)
        }
        
        
        print("DOES NOT CONTAIN ", RideListing.currentUserName!)
        if let name = RideListing.currentUserName {
            if userIsMember {
                
                print("REMOVED FROM LIST")
                riders.removeAll { $0 == name }
            } else {
                print("ADDED TO LIST")
                riders.append(name)
            }
        }
    }
}

//id (of the trip): Int
//destination: String
//date: date time object, takes in string
//distance: Float
//gas_price: float
//drivers: list
//riders: list


//month/day/year (four digits)
