//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Vincent Salinas on 9/29/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
