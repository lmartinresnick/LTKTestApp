//
//  Config.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//
// Inspiration and Documentation from Will Saults

import Foundation

enum Config {
    static let baseURL = requireConfig("API_BASE_URL")
}

private func requireConfig(_ name: String) -> String {
    let maybeValue = Bundle.main.object(forInfoDictionaryKey: name) as? String
    return maybeValue.orElse {
        fatalError("Configuration with name '\(name)' not found")
    }
}

extension Optional {
    public func orElse(_ function: () -> Wrapped) -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return function()
        }
    }
}
