//
//  EntryError.swift
//  Journal-CloudKit
//
//  Created by theevo on 3/30/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case thrown(Error)
    case recordFailedToUnwrap
    case noRecords
    
    var errorDescription: String? {
        switch self {
            
        case .thrown(let error):
            return error.localizedDescription
        case .recordFailedToUnwrap:
            return "A record was returned from the server, but that record failed to unwrap."
        case .noRecords:
            return "Unable to load records."
        
        }
    } // end errorDescription
} // end enum
