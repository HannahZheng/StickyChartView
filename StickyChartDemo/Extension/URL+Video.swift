//
//  URL+VideoImage.swift
//  BeiBei
//
//  Created by Han on 2023/9/20.
//

import Foundation
import AVFoundation
import MobileCoreServices

extension URL: DuoboCompatible {}
extension Duobo where Object == URL {
    /// 获取视频的首帧图
    func getVideoFirstFrameImage() -> UIImage? {
        
        let avAsset = AVURLAsset(url: object)
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0, preferredTimescale: 600)
        var actualTime: CMTime = CMTimeMake(value: 0, timescale: 1)
        var thumbnailImage: UIImage?
        
        do {
            let cgImage = try generator.copyCGImage(at: time, actualTime: &actualTime)
//            let cgImage = try generator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            thumbnailImage = UIImage(cgImage: cgImage)
        } catch let error {
            print("Error generating thumbnail: \(error)")
        }
        
        return thumbnailImage
    }
    /// 压缩视频
    func compressVideo(completion: @escaping (URL?) -> Void) {
        let asset = AVAsset(url: object)
        let path = FileWriteHelper.videoFoler + Date().duobo.getMilliStamp() + ".mp4"
        let outputURL = URL(fileURLWithPath: path)
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality) else {
            completion(nil)
            return
        }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        
        exportSession.exportAsynchronously {
            if exportSession.status == .completed {
                printLog("视频压缩成功")
                completion(outputURL)
            } else {
                completion(nil)
            }
        }
    }
}
