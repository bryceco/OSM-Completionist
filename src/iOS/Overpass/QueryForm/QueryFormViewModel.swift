//
//  QueryFormViewModel.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 5/6/19.
//  Copyright © 2019 Bryce. All rights reserved.
//

import Foundation

protocol QueryFormViewModelDelegate: class {
    /// Asks the delegate to present the preview with the given URL string.
    ///
    /// - Parameter url: The URL of the preview address as a string.
    func presentPreviewWithOverpassTurbo(url: String)
}

class QueryFormViewModel: NSObject {
    
    // MARK: Public properties
    
    var queryText = Observable<String>("")
    var errorMessage = Observable<String>("")
    var isPreviewButtonEnabled = Observable<Bool>(false)
    
    weak var delegate: QueryFormViewModelDelegate?
    
    // MARK: Private properties
    
    private let parser: OverpassQueryParsing
    
    // MARK: Initializer
    
    init(parser: OverpassQueryParsing) {
        self.parser = parser
    }
    
    convenience override init() {
        let parser = OverpassQueryParser()
        
        assert(parser != nil, "Unable to create the query parser.")
        
        self.init(parser: parser!)
    }
    
    // MARK: Public methods
    
    func evaluateQuery(_ query: String) {
        guard !query.isEmpty else {
            errorMessage.value = ""
            isPreviewButtonEnabled.value = false
            return
        }
        
        let result = parser.parse(query)
        
        switch result {
        case .error(let message):
            errorMessage.value = message
            isPreviewButtonEnabled.value = false
        case .success(_):
            errorMessage.value = ""
            isPreviewButtonEnabled.value = true
        }
    }

}
