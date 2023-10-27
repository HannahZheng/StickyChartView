//
//  URL+Extension.swift
//  BeiBei
//
//  Created by Jonhory on 2023/8/22.
//

import Foundation

extension URL {
    
    init?(cString: String) {
        self.init(string: cString.duobo.autoUrlEncoded())
    }
}
