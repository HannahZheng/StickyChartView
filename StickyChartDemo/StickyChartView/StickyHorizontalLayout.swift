//
//  StickyChartHorizontalLayout.swift
//  BeiBei
//
//  Created by Han on 2023/10/25.
//

import UIKit

protocol StickyHorizontalFlowLayoutDelegate: NSObjectProtocol {
    /// cell的宽度
    func cellWidth(for collectionView: UICollectionView, at indexPath: IndexPath) -> CGFloat
}

/// 横向滑动layout
final class StickyHorizontalFlowLayout: UICollectionViewFlowLayout {
    private(set) lazy var cell_attrs: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private(set) lazy var compute_size: CGSize = .zero
    
    weak var delegate: StickyHorizontalFlowLayoutDelegate?
}

extension StickyHorizontalFlowLayout {
    override func prepare() {
        super.prepare()
        cell_attrs.removeAll()
        compute_size = .zero
        
        guard let collView = collectionView else { return  }
        guard let dele = delegate else { return }
        
        compute_size.height = collView.frame.height
        compute_size.width = sectionInset.left
      
        let count = collView.numberOfItems(inSection: 0)
        for item in 0..<count {
            let idp = IndexPath(item: item, section: 0)
            let cellAttr = UICollectionViewLayoutAttributes(forCellWith: idp)
            let width = dele.cellWidth(for: collView, at: idp)
            cellAttr.frame = CGRect(x: compute_size.width, y: sectionInset.top, width: width, height: compute_size.height - sectionInset.top - sectionInset.bottom)
            cell_attrs[idp] = cellAttr
            compute_size.width = cellAttr.frame.maxX
            if item < count-1 {
                compute_size.width += minimumInteritemSpacing
            } else {
                compute_size.width += sectionInset.right
            }
        }
        
    }
}

extension StickyHorizontalFlowLayout {
    override var collectionViewContentSize: CGSize {
        return compute_size
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs: [UICollectionViewLayoutAttributes] = []
        attrs.append(contentsOf: cell_attrs.values.filter({ $0.frame.intersects(rect) }))
        return attrs
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cell_attrs[indexPath]
    }
    
}

