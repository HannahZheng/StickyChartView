//
//  UIImage+Format.swift
//  BeiBei
//
//  Created by Han on 2023/10/19.
//

import UIKit
import CoreGraphics
import MobileCoreServices

extension Duobo where Object == UIImage {
    func getImageFormat() -> (mime: String, suffix: String) {
        var mime_type = "image/png"
        var suffix = ".png"
        guard let cgImage = object.cgImage else { return (mime_type, suffix)  }
        guard let utType = cgImage.utType else { return (mime_type, suffix) }
        switch utType {
        case kUTTypePNG:
            suffix = ".png"
        case kUTTypeJPEG, kUTTypeJPEG2000:
            mime_type = "image/jpeg"
            suffix = ".jpeg"
        case kUTTypeGIF:
            mime_type = "image/gif"
            suffix = ".gif"
        case kUTTypeLivePhoto:
            suffix = ".png"
        case kUTTypeScalableVectorGraphics:
            mime_type = "image/svg+xm"
            suffix = ".png"
        case kUTTypeTIFF:
            mime_type = "image/tiff"
            suffix = ".tiff"
        default: break
            
        }
        return (mime_type, suffix)
        
    }
}

extension Duobo where Object == Data {
    func getImageFormat() -> (mime: String, suffix: String) {
        var mime_type = "image/png"
        var suffix = ".png"
        var buffer = [UInt8](repeating: 0, count: 1)
        (object as NSData).getBytes(&buffer, length: 1)
        switch buffer {
        case [0xFF]:
            mime_type = "image/jpeg"
            suffix = ".jpeg"
        case [0x89]:
            suffix = ".png"
        case [0x47]:
            mime_type = "image/gif"
            suffix = ".gif"
        case [0x49], [0x4D]:
            mime_type = "image/tiff"
            suffix = ".tiff"
        case [0x52] where object.count >= 12:
            if let str = String(data: object.subdata(in: 0..<12), encoding: .ascii), str.hasPrefix("RIFF"), str.hasSuffix("WEBP") {
                mime_type = "image/webp"
                suffix = ".webp"
            }
        default: break
        }
        return (mime_type, suffix)
    }
}
