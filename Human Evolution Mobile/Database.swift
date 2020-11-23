//
//  Database.swift
//  Human Evolution Mobile
//
//  Created by Shreyas Agnihotri on 11/5/20.
//  Copyright © 2020 Shreyas Agnihotri. All rights reserved.
//

import Foundation

struct Fossil {
    var name: String
    var type: String
    var yearDiscovered: Int
    var link: URL
}

let species: [String: [String: Any]] = [
    "Homo erectus": [                                                                   // Species name
        "existedFrom": 7.55,                                                            // Decimal to 2 places, in millions of years ago
        "existedUntil": 3.00,                                                           // Decimal to 2 places, in millions of years ago
        "pins": [(6.6111, 20.9394), (6.6111, 40.9394)],                                 // Array of (lat, long) coordinates for map pins
        "geography": "Eastern Africa (Middle Awash Valley, Ethiopia)",                  // Description of geographic range
        "brainSize": "600-800 cubic centimeters",                                       // Description of brain size
        "moreInfo": "Short paragraph description: diet, behaviors, notable facts",      // Short paragraph description
        "fossils": [                                                                    // One entry for each fossil
            Fossil(name: "KNMER-3733",                                                  // Scientific name
                   type: "Skull",                                                       // Skull/skeleton/foot/whatever
                   yearDiscovered: 2020,                                                // Year
                   link: URL(string: "https://en.wikipedia.org/wiki/KNM_ER_3733")!),    // URL
            Fossil(name: "KNMER-4",
                   type: "Skull",
                   yearDiscovered: 2020,
                   link: URL(string: "https://en.wikipedia.org/wiki/KNM_ER_3733")!)
        ]
    ],
    "Homo sapiens": [
        "existedFrom": 3.55,
        "existedUntil": 1.00,
        "pins": [(7.9, 21.8)],
        "geography": "Eastern Africa (Middle Awash Valley, Ethiopia)",
        "brainSize": "600-800 cubic centimeters",
        "moreInfo": "Short paragraph description: diet, behaviors, notable facts",
        "fossils": [
            Fossil(name: "KNMER-3733",
                   type: "Skull",
                   yearDiscovered: 2020,
                   link: URL(string: "https://en.wikipedia.org/wiki/KNM_ER_3733")!)
        ]
    ],
    "Homo blahblah": [
        "existedFrom": 2.55,
        "existedUntil": 0.00,
        "pins": [(3.4, 21.8)],
        "geography": "Eastern Africa (Middle Awash Valley, Ethiopia)",
        "brainSize": "600-800 cubic centimeters",
        "moreInfo": "Short paragraph description: diet, behaviors, notable facts",
        "fossils": [
            Fossil(name: "KNMER-3733",
                   type: "Skull",
                   yearDiscovered: 2020,
                   link: URL(string: "https://en.wikipedia.org/wiki/KNM_ER_3733")!)
        ]
    ],
]
