//
//  MediaObject.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

struct MediaObject: Codable {
    let id: String?
    let type: String?
    let createdAt: String?
    let updatedAt: String?
    let mediaCdnUrl: String?
    let brandedMediaCdnUrl: String?
    let passthroughMediaCdnUrl: String?
    let typeProperties: TypeProperties?
    let thumbnailIds: String?
}
