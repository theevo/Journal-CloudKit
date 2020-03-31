//
//  EntryController.swift
//  Journal-CloudKit
//
//  Created by theevo on 3/30/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import CloudKit

class EntryController {
    
    // MARK: - Source of Truth and Shared Instance
    
    static let shared = EntryController()
    var entries: [Entry] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    
    // MARK: - CRUD
    
    func saveEntry(title: String, body: String, completion: @escaping (Result<Entry?,EntryError>) -> Void) {
        
        let entry = Entry(title: title, body: body)
        
        let record = CKRecord(entry: entry)
        
        privateDB.save(record) { (record, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            
            guard let record = record,
                let entry = Entry(ckRecord: record) else
            { return completion(.failure(.recordFailedToUnwrap)) }
            
            self.entries.append(entry) // Alternative
            
            return completion(.success(entry))
        }
    } // end saveEntry
    
    
    func fetchAllEntries(completion: @escaping (Result<[Entry]?,EntryError>) -> Void) {
        
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryStrings.recordTypeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            
            guard let records = records else {
                return completion(.failure(.noRecords)) }
            
            let entries = records.compactMap({ Entry(ckRecord: $0) })
            
            self.entries = entries
            return completion(.success(entries))
        }
        
    } // end fetchAllEntries
} // EntryController
