//
//  ReusableViewExtensions.swift
//  MobileScanKing
//
//  Created by Han on 2022/3/18.
//

import UIKit

protocol ReusableViewable: NSObjectProtocol {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableViewable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewable {}
extension UITableViewHeaderFooterView: ReusableViewable {}

extension Duobo where Object: UITableView {
    /// 加载可重复使用的UITableViewCell
    /// 使用此方法无需registerCell
    /// - Parameter initialize: UITableViewCell 的初始化
    /// - Returns: UITableViewCell
    func dequeueReusableCell<T: ReusableViewable>(initialize: ((String) -> T)? = nil) -> T where T: UITableViewCell {
        
        func initCell() -> T {
            return initialize?(T.defaultReuseIdentifier) ?? T(style: .default, reuseIdentifier: T.defaultReuseIdentifier)
        }
        let cell = object.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T ?? initCell()
        return cell
    }
    /// 加载可重复使用的UITableViewHeaderFooterView
    /// 使用此方法无需registerHeaderFooterView
    /// - Parameter initialize: UITableViewHeaderFooterView 的初始化
    /// - Returns: UITableViewHeaderFooterView
    func dequeueReusableHeaderFooterView<T: ReusableViewable>(initialize: ((String) -> T)? = nil) -> T where T: UITableViewHeaderFooterView {
        func initView() -> T {
            return initialize?(T.defaultReuseIdentifier) ?? T()
        }
        let view = object.dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T ?? initView()
        return view
    }
}

extension UICollectionReusableView: ReusableViewable {}

extension Duobo where Object: UICollectionView {
    /// collectionView 注册cell
    func registerCell<T>(_: T.Type) where T: UICollectionViewCell {
        object.register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    /// 需要先行注册cell
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = object.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    /// collectionView 注册SupplementaryView
    func registerSupplementaryView<T>(_: T.Type, forkind kind: UICollectionElementKind) where T: UICollectionReusableView {
        object.register(T.self, forSupplementaryViewOfKind: kind.kind, withReuseIdentifier: T.defaultReuseIdentifier)
    }
    /// 需要先行注册SupplementaryView
    func dequeueSupplementaryView<T>(for kind: UICollectionElementKind, indexPath: IndexPath) -> T where T: UICollectionReusableView {
        guard let cell = object.dequeueReusableSupplementaryView(ofKind: kind.kind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue SupplementaryView with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
}

///  简写， 与UICollectionView.elementKindSectionHeader/Footer可相互转换
public enum UICollectionElementKind {
    case header, footer
    init(string: String) {
        switch string {
        case UICollectionView.elementKindSectionHeader: self = .header
        case UICollectionView.elementKindSectionFooter: self = .footer
        default: self = .header
        }
    }
    
    var kind: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}
