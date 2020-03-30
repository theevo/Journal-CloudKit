//
//  Entry.swift
//  Journal-CloudKit
//
//  Created by theevo on 3/30/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import CloudKit

// MARK: - Constants

struct EntryStrings {
    static let recordTypeKey = "Entry"
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timestampKey = "timestamp"
}


// MARK: - Model

class Entry {
    let title: String
    let body: String
    let timestamp: Date
    
    init(title: String, body: String, timestamp: Date = Date()) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

// Incoming <---- (CKRecord into Entry)

extension Entry {
    
    convenience init?(ckRecord: CKRecord) {
        
        // get properties
        guard let title = ckRecord[EntryStrings.titleKey] as? String,
            let body = ckRecord[EntryStrings.bodyKey] as? String,
            let timestamp = ckRecord[EntryStrings.timestampKey] as? Date
            else { return nil }
        
        // init
        self.init(title: title, body: body, timestamp: timestamp)
    }
}


// Outgoing ---> (Entry into CKRecord)

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryStrings.recordTypeKey)
        
        self.setValue(entry.title, forKey: EntryStrings.bodyKey)
        self.setValue(entry.body, forKey: EntryStrings.bodyKey)
        self.setValue(entry.timestamp, forKey: EntryStrings.timestampKey)
    }
}
