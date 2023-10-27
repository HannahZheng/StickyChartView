//
//  UIImageView+UrlString.swift
//  BeiBei
//
//  Created by Han on 2023/9/12.
//

import UIKit
import Kingfisher
import KingfisherWebP

extension Duobo where Object: UIImageView {
    func setUrl(str: String, placeholder: UIImage? = nil, 
                handle_webp: Bool = true,
                completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        let isWebp = str.lowercased().hasSuffix(".webp")
        if handle_webp, isWebp {
           
            object.kf.setImage(with: URL(string: str),
                               placeholder: placeholder,
                               options: [.processor(WebPProcessor.default),
                                         .cacheSerializer(WebPSerializer.default)],
                               progressBlock: nil,
                               completionHandler: completionHandler)
        } else {
            object.kf.setImage(with: URL(string: str), 
                               placeholder: placeholder,
                               completionHandler: completionHandler)
        }
    }
    
    func setUrl(url: URL?, 
                placeholder: UIImage? = nil,
                handle_webp: Bool = true,
                completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        var isWebp = false
        if let ul = url, ul.absoluteString.lowercased().hasSuffix(".webp") {
            isWebp = true
        }
        if handle_webp, isWebp {
            
            object.kf.setImage(with: url,
                               placeholder: placeholder,
                               options: [.processor(WebPProcessor.default),
                                .cacheSerializer(WebPSerializer.default)],
                               progressBlock: nil,
                               completionHandler: completionHandler)
        } else {
            object.kf.setImage(with: url, 
                               placeholder: placeholder, 
                               completionHandler: completionHandler)
        }
    }
}
