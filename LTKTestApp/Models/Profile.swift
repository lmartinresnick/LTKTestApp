//
//  Profile.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

struct Profile: Codable {
    let id: String?
    let avatarUrl: String?
    let avatarUploadUrl: String?
    let displayName: String?
    let fullName: String?
    let instagramName: String?
    let blogName: String?
    let blogUrl: String?
    let bgImageUrl: String?
    let bgUploadUrl: String?
    let bio: String?
    let rsAccountId: Int?
    let searchable: Bool?
}

extension Profile {
    func convertAvatarUrlToUrl() -> URL? {
        avatarUrl?.toUrl()
    }
}

