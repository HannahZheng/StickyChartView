//
//  KeyedDecodingContainer+Parse.swift
//  BeiBei
//
//  Created by Han on 2023/7/24.
//

import Foundation

extension KeyedDecodingContainer where Key: CodingKey {
    /// 从`data`种解析出`int`类型的`必有`字段----(因为某种原因,这个字段可能一会是`int`,一会是`string`)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToInt(forKey key: KeyedDecodingContainer<K>.Key, defaultValue: Int = 0) -> Int {
        if let obj = try? decode(Int.self, forKey: key) {
            return obj
        } else if let obj = try? decode(String.self, forKey: key) {
            return obj.duobo.int
        } else if let obj = try? decode(Bool.self, forKey: key) {
            return obj == false ? 0 : 1
        } else if let obj = try? decode(Double.self, forKey: key) {
            return Int(obj)
        } else {
            return defaultValue
        }
    }
    
    /// 从`data`种解析出`string`类型的`必有`字段----(因为某种原因,这个字段可能一会是`int`,一会是`string`)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToString(forKey key: KeyedDecodingContainer<K>.Key) -> String {
        if let obj = try? decode(String.self, forKey: key) {
            return obj
        } else if let obj = try? decode(Int.self, forKey: key) {
            return "\(obj)"
        } else if let obj = try? decode(Bool.self, forKey: key) {
            return obj ? "true" : "false"
        } else if let obj = try? decode(Double.self, forKey: key) {
            return String(format: "%.2f", obj)
        } else {
            return ""
        }
    }
    
    /// 从`data`种解析出`Bool`类型的`必有`字段----(因为某种原因,这个字段可能一会是`int`,一会是`string`)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToBool(forKey key: KeyedDecodingContainer<K>.Key, defaultValue: Bool = false) -> Bool {
        if let obj = try? decode(Bool.self, forKey: key) {
            return obj
        } else if let obj = try? decode(Int.self, forKey: key) {
            return obj > 0
        } else if let obj = try? decode(String.self, forKey: key) {
            switch obj {
            case "true": return true
            case "1": return true
            default: return false
            }
        } else if let obj = try? decode(Double.self, forKey: key) {
            return obj > 0
        } else {
            return defaultValue
        }
    }
    
    /// 从`data`种解析出`Double`类型的`必有`字段----(因为某种原因,这个字段可能一会是`Bool`,一会是`string`)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToDouble(forKey key: KeyedDecodingContainer<K>.Key) -> Double {
        if let obj = try? decode(Double.self, forKey: key) {
            return obj
        } else if let obj = try? decode(Int.self, forKey: key) {
            return Double(obj)
        } else if let obj = try? decode(Bool.self, forKey: key) {
            return obj ? 1.0 : 0.0
        } else if let obj = try? decode(String.self, forKey: key) {
            return obj.duobo.double
        } else {
            return 0.0
        }
    }

    /// 从`data`种解析出`[]`类型的`必有`字段----(因为某种原因,这个字段未返回)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToArray<T: Decodable>(forKey key: KeyedDecodingContainer<K>.Key) -> [T] {
        if let obj = try? decodeIfPresent([T].self, forKey: key) {
            return obj
        } else {
            return []
        }
    }

}

// MARK: IfPresent
extension KeyedDecodingContainer where Key: CodingKey {
    /// 从`data`种解析出`int`类型的`可选`字段----(因为某种原因,这个字段可能一会是`int`,一会是`string`)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToIntIfPresent(forKey key: KeyedDecodingContainer<K>.Key) -> Int? {
        if let obj = try? decodeIfPresent(Int.self, forKey: key) {
            return obj
        } else if let obj = try? decodeIfPresent(String.self, forKey: key) {
            return obj.duobo.int
        } else if let obj = try? decode(Bool.self, forKey: key) {
            return obj == false ? 0 : 1
        } else if let obj = try? decode(Double.self, forKey: key) {
            return Int(obj)
        } else {
            return nil
        }
    }
    
    /// 从`data`种解析出`string`类型的`可选`字段----(因为某种原因,这个字段可能一会是`int`,一会是`string`)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToStringIfPresent(forKey key: KeyedDecodingContainer<K>.Key) -> String? {
        if let obj = try? decodeIfPresent(String.self, forKey: key) {
            return obj
        } else if let obj = try? decodeIfPresent(Int.self, forKey: key) {
            return "\(obj)"
        } else if let obj = try? decode(Bool.self, forKey: key) {
            return obj ? "true" : "false"
        } else if let obj = try? decode(Double.self, forKey: key) {
            return String(format: "%.2f", obj)
        } else {
            return nil
        }
    }
    
    /// 从`data`种解析出`Bool`类型的`可选`字段----(因为某种原因,这个字段可能一会是`int`,一会是`string`)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToBoolIfPresent(forKey key: KeyedDecodingContainer<K>.Key) -> Bool? {
        if let obj = try? decode(Bool.self, forKey: key) {
            return obj
        } else if let obj = try? decode(Int.self, forKey: key) {
            return obj > 0
        } else if let obj = try? decode(String.self, forKey: key) {
            switch obj {
            case "true": return true
            default: return false
            }
        } else if let obj = try? decode(Double.self, forKey: key) {
            return obj > 0
        } else {
            return nil
        }
    }
    
    /// 从`data`种解析出`Double`类型的`可选`字段----(因为某种原因,这个字段可能一会是`Bool`,一会是`string`)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToDoubleIfPresent(forKey key: KeyedDecodingContainer<K>.Key) -> Double? {
        if let obj = try? decode(Double.self, forKey: key) {
            return obj
        } else if let obj = try? decode(Int.self, forKey: key) {
            return Double(obj)
        } else if let obj = try? decode(Bool.self, forKey: key) {
            return obj ? 1.0 : 0.0
        } else if let obj = try? decode(String.self, forKey: key) {
            return obj.duobo.double
        } else {
            return nil
        }
    }

    /// 从`data`种解析出`[]`类型的`可选`字段----(因为某种原因,这个字段未返回)
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToArrayIfPresent<T: Decodable>(forKey key: KeyedDecodingContainer<K>.Key) -> [T]? {
        if let obj = try? decodeIfPresent([T].self, forKey: key) {
            return obj
        } else {
            return nil
        }
    }
    
    /// 从`data`种解析出`{}`类型的`可选`字段----(因为某种原因,这个字段未返回  或者返回{})
    /// - Parameter key: 对应字段的key
    /// - Returns: 返回解析出来的值
    func decodeToObjIfPresent<T: Decodable>(forKey key: KeyedDecodingContainer<K>.Key) -> T? {
        if let obj = try? decodeIfPresent(T.self, forKey: key) {
                let mirror = Mirror(reflecting: obj)
                let propertyCount = mirror.children.count
                return propertyCount > 0 ? obj : nil
            } else {
                return nil
            }
    }
   
}
