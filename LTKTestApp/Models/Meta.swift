//
//  Meta.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

struct Meta: Codable {
    let lastId: String?
    let numResults: Int?
    let totalResults: Int?
    let limit: Int?
    let seed: String?
    let nextUrl: String?
}
