//
//  Experience.swift
//  MyResume
//
//  Created by Chen Le on 30/03/2022.
//

import Foundation
import CoreLocation

enum ExperienceType: String, CaseIterable {
    case all, work, project, education
    
    var displayName: String { rawValue.capitalized }
}

struct Experience: Identifiable, Equatable, Comparable {
    var id = UUID()
    var title: String
    var description: [String]
    var type: ExperienceType
    var startDate: String // eg: Jan 2022
    var endDate: String?
    let imageNames: [String]
    var location: Location
    var link: String?
    
    var sDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM y"
        return formatter.date(from: startDate) ?? Date.now
    }
    
    static func <(lhs: Experience, rhs: Experience) -> Bool {
        lhs.sDate > rhs.sDate
    }
}

struct Location: Equatable {
    
    var id: UUID
    var name: String
    var country: String
    var latitude: Double
    var longitude: Double

    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "China Mobile International", country: "Malaysia", latitude: 2.9227822273455186, longitude: 101.66132276403583)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
