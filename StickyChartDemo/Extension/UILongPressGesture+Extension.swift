//
//  UILongPressGesture+Extension.swift
//  BeiBei
//
//  Created by Han on 2023/7/22.
//

import UIKit

extension UILongPressGestureRecognizer: DuoboCompatible {}
extension Duobo where Object == UILongPressGestureRecognizer {
    /// 默认1秒内失效 block press响应的block
    func secondsUnable(_ sec: TimeInterval = 1, block: ( () -> Void)?) {
        guard object.isEnabled else {
            return
        }
        block?()
        object.isEnabled = false
        DispatchQueue.global().asyncAfter(deadline: .now() + sec) { [weak object] in
            DispatchQueue.main.async {
                object?.isEnabled = true
            }
        }
    }
}
extension UITapGestureRecognizer: DuoboCompatible {}
extension Duobo where Object == UITapGestureRecognizer {
    /// 默认1秒内失效 block press响应的block
    func secondsUnable(_ sec: TimeInterval = 1, block: ( () -> Void)?) {
        guard object.isEnabled else {
            return
        }
        block?()
        object.isEnabled = false
        DispatchQueue.global().asyncAfter(deadline: .now() + sec) { [weak object] in
            DispatchQueue.main.async {
                object?.isEnabled = true
            }
        }
    }
}

extension Duobo where Object == UIButton {
    // 默认1秒内失效 block btn响应的block
    func secondsUnable(_ sec: TimeInterval = 1, block: ( () -> Void)?) {
        guard object.isUserInteractionEnabled else {
            return
        }
        block?()
        object.isUserInteractionEnabled = false
        DispatchQueue.global().asyncAfter(deadline: .now() + sec) { [weak object] in
            DispatchQueue.main.async {
                object?.isUserInteractionEnabled = true
            }
            
        }
    }
}
