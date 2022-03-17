//
//  WalkthoughModel.swift
//  SwiftUI-WalkThough
//
//  Created by Waleerat Gottlieb on 2022-03-17.
//

import Foundation


struct WalkThoughModel: Identifiable, Hashable {
    var id: String
    var order: Int
    var title: String
    var description: String
    var imageURL: String
    var bgColorHex: String
    var foregroundColorHex: String
    var isActive:Bool
 
    
    init(_id: String, _order: Int, _title: String, _description: String, _imageURL: String, _bgColorHex: String,
         _foregroundColorHex: String, _isActive:Bool) {
        id = _id
        order = _order
        title = _title
        description = _description
        imageURL = _imageURL
        bgColorHex = _bgColorHex.isEmpty ? "#192A44" : _bgColorHex
        foregroundColorHex = _foregroundColorHex.isEmpty ? "#FFFFFF" : _foregroundColorHex
        isActive = _isActive
    }
}
