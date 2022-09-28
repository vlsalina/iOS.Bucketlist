//
//  Location.swift
//  BucketList
//
//  Created by Vincent Salinas on 9/28/22.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
