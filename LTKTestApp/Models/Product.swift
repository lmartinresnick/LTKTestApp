//
//  Product.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

struct Product: Codable {
    let id: String?
    let ltkId: String?
    let hyperlink: String?
    let imageUrl: String?
    let matching: String?
    let productDetailsId: String?
}

extension Product {
    enum UrlType {
        case hyperlink
        case image
    }
    
    func convertToUrl(for type: UrlType) -> URL? {
        switch type {
        case .hyperlink:
            return hyperlink?.toUrl()
        case .image:
            return imageUrl?.toUrl()
        }
    }
}
