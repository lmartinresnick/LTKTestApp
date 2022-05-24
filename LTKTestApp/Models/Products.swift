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
    // let links: String?
    let matching: String?
    let productDetailsId: String?
}

//{
//      "id": "803c22da-d638-11ec-9ea9-0242ac110003",
//      "ltk_id": "7ec089a9-d638-11ec-ba07-0242ac110003",
//      "hyperlink": "https://rstyle.me/+eV1pEZP_a-BSDv7K_oXAAw?li=7ec089a9-d638-11ec-ba07-0242ac110003&lpm=EXACT",
//      "image_url": "https://images.rewardstyle.com/img?v=1&width=256&height=256&crop&p=210345603",
//      "links": {
//        "ANDROID_CONSUMER_APP": "https://rstyle.me/+eV1pEZP_a-BSDv7K_oXAAw?__cid=1945&li=7ec089a9-d638-11ec-ba07-0242ac110003&lpm=EXACT",
//        "ANDROID_CONSUMER_APP_SS": "https://rstyle.me/+eV1pEZP_a-BSDv7K_oXAAw?__cid=1946&li=7ec089a9-d638-11ec-ba07-0242ac110003&lpm=EXACT",
//        "IOS_CONSUMER_APP": "https://rstyle.me/+eV1pEZP_a-BSDv7K_oXAAw?__cid=1907&li=7ec089a9-d638-11ec-ba07-0242ac110003&lpm=EXACT",
//        "IOS_CONSUMER_APP_SS": "https://rstyle.me/+eV1pEZP_a-BSDv7K_oXAAw?__cid=1908&li=7ec089a9-d638-11ec-ba07-0242ac110003&lpm=EXACT",
//        "LTK_EMAIL": "https://rstyle.me/+eV1pEZP_a-BSDv7K_oXAAw?__cid=1141&li=7ec089a9-d638-11ec-ba07-0242ac110003&lpm=EXACT",
//        "LTK_WEB": "https://rstyle.me/+eV1pEZP_a-BSDv7K_oXAAw?__cid=1144&li=7ec089a9-d638-11ec-ba07-0242ac110003&lpm=EXACT",
//        "LTK_WIDGET": "https://rstyle.me/+eV1pEZP_a-BSDv7K_oXAAw?__cid=1843&li=7ec089a9-d638-11ec-ba07-0242ac110003&lpm=EXACT",
//        "TAILORED_EMAIL": "https://rstyle.me/+eV1pEZP_a-BSDv7K_oXAAw?1141=7ec089a9-d638-11ec-ba07-0242ac110003&__cid=1875&li=7ec089a9-d638-11ec-ba07-0242ac110003&lpm=EXACT"
//      },
//      "matching": "EXACT",
//      "product_details_id": "210345603:2"
//    }
