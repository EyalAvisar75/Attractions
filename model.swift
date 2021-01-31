//
//  model.swift
//  Attractions
//
//  Created by eyal avisar on 28/01/2021.
//

import Foundation

var attractions:[[String:Any]] = []
var attractionsByCategories:[[[String:Any]]] = []
var categories:[[String:Any]] = []


func populateModels() {
    var attractionsCategory1:[[String:Any]] = []
    var attractionsCategory2:[[String:Any]] = []
    var attractionsCategory3:[[String:Any]] = []
    var attractionsCategory4:[[String:Any]] = []
    var attractionsCategory5:[[String:Any]] = []
    
    for attraction in attractions {
        switch attraction["CatId"] as! Int {
        case 1:
            attractionsCategory1.append(attraction)
        case 2:
            attractionsCategory2.append(attraction)
        case 3:
            attractionsCategory3.append(attraction)
        case 4:
            attractionsCategory4.append(attraction)
        case 5:
            attractionsCategory5.append(attraction)
        default:
            break
        }
    }
    attractionsByCategories.append(attractionsCategory1)
    attractionsByCategories.append(attractionsCategory2)
    attractionsByCategories.append(attractionsCategory3)
    attractionsByCategories.append(attractionsCategory4)
    attractionsByCategories.append(attractionsCategory5)
    
//    for array in attractionsByCategories.enumerated() {
//        print("array:", array)
//    }
}
