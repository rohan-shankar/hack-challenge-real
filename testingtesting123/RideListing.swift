//
//  RideListing.swift
//  testingtesting123
//
//  Created by Rohan Shankar on 12/3/24.
//

struct RideListing {
    var driver: String
    var price: String
    var members: [String]
    var location: String
    var userIsMember: Bool {
        members.contains(RideListing.currentUserName ?? "")
    }

    static var currentUserName: String?

    mutating func toggleMembership() {
        if let name = RideListing.currentUserName {
            if userIsMember {
                members.removeAll { $0 == name }
            } else {
                members.append(name)
            }
        }
    }
}
