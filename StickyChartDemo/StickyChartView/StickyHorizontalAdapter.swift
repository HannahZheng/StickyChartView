//
//  StickyHorizontalAdapter.swift
//  BeiBei
//
//  Created by Han on 2023/10/26.
//

import UIKit

final class StickyHorizontalAdapter: NSObject {
    private(set) lazy var flowLayout = StickyHorizontalFlowLayout()
    
    private(set) lazy var mainView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.duobo.registerCell(StickyCell.self)
        return view
    }()
    
    var datas: [String] = []
    var configCell: ( (IndexPath, StickyCell) -> Void )?
    
    var scrollBlock: ( (CGPoint) -> Void )?
    var is_reset_offset: Bool = false
    
    var clickCell: ( (IndexPath) -> Void )?
    
    override init() {
        super.init()
        mainView.dataSource = self
        mainView.delegate = self
        
        //
    }
}

extension StickyHorizontalAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StickyCell = collectionView.duobo.dequeueReusableCell(for: indexPath)
        if indexPath.item < datas.count {
            cell.label.text = datas[indexPath.item]
        }
        configCell?(indexPath, cell)
        return cell
    }
}

extension StickyHorizontalAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        printLog("点击列表中的item cell")
        clickCell?(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard is_reset_offset == false else {
            return
        }
        scrollBlock?(scrollView.contentOffset)
    }
}
