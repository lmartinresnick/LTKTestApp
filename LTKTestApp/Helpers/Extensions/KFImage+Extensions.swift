//
//  KFImage+Extensions.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Kingfisher
import SwiftUI

extension KFImage {
    func basicKFModifiers() -> KFImage {
        return
          self
            .placeholder({
                ProgressView()
            })
            .setProcessor(DefaultImageProcessor.default)
            .cacheOriginalImage()
            .resizable()
      }
}
