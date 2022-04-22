//
//  Personal.swift
//  MyResume
//
//  Created by Chen Le on 08/04/2022.
//

import Foundation

struct Personal {
    let firstName: String
    let lastName: String
    var fullName: String {
        firstName + ", " + lastName
    }
    let email: String
    let contactNumber: String
    let personalImage: String?
    
    var executiveSummary: String
    var education: Experience
    
    var language: [Language]
    
    var skills: [String]
    var certificates: [String]?
}

struct Language: Hashable {
    var name: String
    var value: Int
}
