//
//  ProductImageCellView.swift
//  LTKTestApp
//
//  Created by Luke Martin-Resnick on 5/23/22.
//

import Kingfisher
import SafariServices
import SwiftUI
import SwiftySwiftUI

struct ProductImageCellView: View {
    var product: Product
    
    init(for product: Product) {
        self.product = product
    }
    
    var body: some View {
        Button {
            HapticFeedbackGenerator.impactOccurred()
            guard let url = product.convertToUrl(for: .hyperlink) else {
                return
            }
            
            let controller = SFSafariViewController(url: url)
            UIApplication.getRootViewController()?.present(controller, animated: true)
        } label: {
            KFImage(product.convertToUrl(for: .image))
                .basicKFModifiers()
                .scaledToFit()
                .frame(height: 100)
                .customShadow()
        }
    }
}

//struct ProductImageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductImageCell(for: Product())
//    }
//}
