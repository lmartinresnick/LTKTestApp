//
//  LTK.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

struct LTK: Codable, Identifiable {
    let id: String?
    let heroImage: String?
    let heroImageWidth: Int?
    let heroImageHeight: Int?
    let profileId: String?
    let profileUserId: String?
    let videoMediaId: String?
    let status: String?
    let caption: String?
    let shareUrl: String?
    let dateCreated: String?
    let dateUpdated: String?
    let dateScheduled: String?
    let datePublished: String?
    let productIds: [String]?
    let hash: String?
}

extension LTK {
    func convertHeroImageToUrl() -> URL? {
        heroImage?.toUrl()
    }
}

