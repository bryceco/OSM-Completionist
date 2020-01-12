//
//  MapViewViewModel.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation

class MapViewViewModel: NSObject {
    // MARK: Private properties
    
    private let activeQuestBaseObjectMatcher: ActiveQuestBaseObjectMatching
    
    // MARK: Initializer
    
    init(activeQuestBaseObjectMatcher: ActiveQuestBaseObjectMatching) {
        self.activeQuestBaseObjectMatcher = activeQuestBaseObjectMatcher
    }
    
    override convenience init() {
        let staticQuestProvider = StaticQuestProvider()
        let activeQuestBaseObjectMatcher = ActiveQuestsBaseObjectMatcher(questProvider: staticQuestProvider)
        
        self.init(activeQuestBaseObjectMatcher: activeQuestBaseObjectMatcher)
    }
    
    // MARK: Public methods
    
    @objc func presentQuestInterface(for baseObject: OsmBaseObject) -> Bool {
        return !activeQuestBaseObjectMatcher.quests(matching: baseObject).isEmpty
    }
}
