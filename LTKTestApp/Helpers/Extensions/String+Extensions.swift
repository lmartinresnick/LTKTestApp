//
//  String+Extensions.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Foundation

extension String {
    func toUrl() -> URL? {
        URL(string: self)
    }
}
