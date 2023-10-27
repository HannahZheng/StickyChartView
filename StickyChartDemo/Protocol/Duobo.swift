//
//  Duo.swift
//
//
//  Created by han on 2022/3/16.
//

import Foundation

/// 用于对系统类、基本数据类型等进行自定义扩展方法：1.先遵循DuoboCompatible（仅遵循一次即可）2. 譬如extension Duobo where Object == Int { 自定义方法 }
 public class Duobo<Object> {

     let object: Object

     init(_ base: Object) {
         self.object = base
     }
}

public protocol DuoboCompatible {}

public extension DuoboCompatible {

    var duobo: Duobo<Self> {
        get { Duobo(self) }
        // swiftlint:disable unused_setter_value
        set {}
        // swiftlint:enable unused_setter_value
    }

    static var duobo: Duobo<Self>.Type {
        get { Duobo<Self>.self }
        // swiftlint:disable unused_setter_value
        set {}
        // swiftlint:enable unused_setter_value
    }
}
