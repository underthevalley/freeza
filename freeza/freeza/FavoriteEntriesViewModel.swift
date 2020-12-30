//
//  FavoriteEntriesViewModel.swift
//  freeza
//
//  Created by Nat Sibaja on 12/30/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation

class FavoriteEntriesViewModel {
    var hasError = false
    var errorMessage: String? = nil
    var entries = [EntryViewModel]()
    
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    
    func loadEntriesFromDB(withCompletion completion: @escaping () -> ()) {
        entries = []
        let context = CoreDataStack.shared.persistentContainer.viewContext
        guard let data = DBEntry.loadEntriesFromDB(context: context) else { return }
        for entryModel in data {
            let entryViewModel = EntryViewModel(withModel: entryModel)
            entryViewModel.isFavorite = true
            self.entries.append(entryViewModel)
        }
        DispatchQueue.main.async {
            completion()
        }
    }
}
