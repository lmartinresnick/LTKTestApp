//
//  Feed.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

struct Feed: Codable {
    var ltks: [LTK]?
    var profiles: [Profile]?
    var meta: Meta?
    var products: [Product]?
    var mediaObjects: [MediaObject]?
}
