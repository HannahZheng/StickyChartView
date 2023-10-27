//
//  StickyListAdapter.swift
//  BeiBei
//
//  Created by Han on 2023/10/26.
//

import UIKit

protocol StickyListAdapterDelegate: NSObjectProtocol {
    /// 标题数组
    func titles() -> [String]
    /// cell 数组 二维数组
    func datas() -> [[String]]
    /// 左侧固定不动的iten 个数
    func fixedCount() -> Int
    /// 一行所有的item的宽度数组
    func itemWidths() -> [CGFloat]
    /// 标题cell 样式更改
    func configTitleCell(header: StickyHorizontalCell)
    /// listCell 样式更改
    func configListCell(at indexPath: IndexPath, cell: StickyHorizontalCell)
    /// 标题 item 样式更改
    func configTitleItem(at indexPath: IndexPath, item cell: StickyCell)
    /// cell item样式更改
    func configListItem(at indexPath: IndexPath, item cell: StickyCell)
    
    /// 点击标题上的item
    func clickTitleItem(at indexPath: IndexPath, isLeft: Bool)
    /// 单行cell 点击
    func clickCell(at indexPath: IndexPath, isLeft: Bool, itemIndexPath: IndexPath)
}

extension StickyListAdapterDelegate {
    /// 标题cell 样式更改
    func configTitleCell(header: StickyHorizontalCell) {}
    /// listCell 样式更改
    func configListCell(at indexPath: IndexPath, cell: StickyHorizontalCell) {}
    /// 标题 item 样式更改
    func configTitleItem(at indexPath: IndexPath, item cell: StickyCell) {}
    /// cell item样式更改
    func configListItem(at indexPath: IndexPath, item cell: StickyCell) {}
    /// 点击标题上的item
    func clickTitleItem(at indexPath: IndexPath, isLeft: Bool) {}
}

final class StickyListAdapter: NSObject {
    private(set) lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0).duobo.less
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: sWidth, height: 26.duobo.less)
        layout.headerReferenceSize = CGSize(width: sWidth, height: 36.duobo.less)
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }()
    
    private(set) lazy var mainView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.duobo.registerCell(StickyHorizontalCell.self)
        view.duobo.registerSupplementaryView(StickyHorizontalCell.self, forkind: .header)
        return view
    }()
    
    private var offsetX: CGFloat = 0
    private var max_offsetX: CGFloat = 0
    private var forView: UIView!
    
    weak var delegate: StickyListAdapterDelegate?
    
    convenience init(forView: UIView) {
        self.init()
        self.forView = forView
        mainView.dataSource = self
        mainView.delegate = self
    
        // 采用手势也可实现 但没有那么顺滑
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPanGestureHandle(_:)))
//        forView.addGestureRecognizer(pan)
    }
}

extension StickyListAdapter: UIGestureRecognizerDelegate {
    @IBAction func didPanGestureHandle(_ pan: UIPanGestureRecognizer) {
        guard pan.state == .changed else { return }
        let translation = pan.translation(in: self.forView)
        defer {
            pan.setTranslation(.zero, in: self.forView)
        }
       
        offsetX -= translation.x
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > max_offsetX {
            offsetX = max_offsetX
        }
        mainView.reloadData()
    }

}

extension StickyListAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dele = delegate else { return 0 }
        return dele.datas().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StickyHorizontalCell = collectionView.duobo.dequeueReusableCell(for: indexPath)
        if let dele = delegate {
            var datas: [String] = []
            if indexPath.item < dele.datas().count {
                datas = dele.datas()[indexPath.item]
            }
            
            cell.leftAdapter.configCell = { [weak self] idp, item in
                guard let self = self else { return }
                self.delegate?.configListItem(at: idp, item: item)
            }
            cell.rightAdapter.configCell = { [weak self] idp, item in
                guard let self = self else { return }
                self.delegate?.configListItem(at: idp, item: item)
            }
            dele.configListCell(at: indexPath, cell: cell)
            cell.config(datas: datas, fixedCount: dele.fixedCount(), widths: dele.itemWidths(), offsetX: offsetX)
        }
        
        cell.scrollBlock = { [weak self] offset in
            guard let self = self else { return }
            self.offsetX = offset.x
            self.mainView.reloadData()
        }
        
        cell.clickBlock = { [weak self] isLeft, idp in
            guard let self = self else { return }
            self.delegate?.clickCell(at: indexPath, isLeft: isLeft, itemIndexPath: idp)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        guard let dele = delegate else { return UICollectionReusableView() }
        
        let header: StickyHorizontalCell = collectionView.duobo.dequeueSupplementaryView(for: .header, indexPath: indexPath)
        header.backgroundColor = .white
        
        header.leftAdapter.configCell = { [weak self] idp, item in
            guard let self = self else { return }
            self.delegate?.configTitleItem(at: idp, item: item)
        }
        header.rightAdapter.configCell = { [weak self] idp, item in
            guard let self = self else { return }
            self.delegate?.configTitleItem(at: idp, item: item)
        }
        
        header.clickBlock = { [weak self] isLeft, idp in
            guard let self = self else { return }
            self.delegate?.clickTitleItem(at: idp, isLeft: isLeft)
        }
        
        dele.configTitleCell(header: header)
        
        header.config(datas: dele.titles(), fixedCount: dele.fixedCount(), widths: dele.itemWidths(), offsetX: offsetX)
        
        max_offsetX = header.rightAdapter.flowLayout.compute_size.width
        
        header.scrollBlock = { [weak self] offset in
            guard let self = self else { return }
            self.offsetX = offset.x
            self.mainView.reloadData()
        }
        return header
    }
}

extension StickyListAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        printLog("点击列表cell")
    }
}
