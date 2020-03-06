//
//  MapRouletteTask.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 3/6/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import MapRoulette

struct MapRouletteTask {
    let id: Int64
    let coordinate: CLLocationCoordinate2D
    
    init(clusteredPoint: OrgMaprouletteModelsClusteredPoint) {
        self.id = clusteredPoint._id
        self.coordinate = CLLocationCoordinate2D(mapRoulettePoint: clusteredPoint.point)
    }
}

extension MapRouletteTask: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

func ==(lhs: MapRouletteTask, rhs: MapRouletteTask) -> Bool {
    return lhs.id == rhs.id
}
