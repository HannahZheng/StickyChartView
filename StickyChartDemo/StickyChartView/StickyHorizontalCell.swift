//
//  StickyHorizontalCell.swift
//  BeiBei
//
//  Created by Han on 2023/10/25.
//
import UIKit

final class StickyHorizontalCell: UICollectionViewCell {
    private(set) lazy var leftAdapter = StickyHorizontalAdapter()
    private(set) lazy var rightAdapter = StickyHorizontalAdapter()
    
    private var datas: [String] = []
    private var fixedCount: Int = 0
    private var cellWidths: [CGFloat] = []
    private var offsetX: CGFloat = 0
    
    var textFont: UIFont = UIFont.duobo.regularFont(size: 14.duobo.less)
    var textColor: UIColor = .rgba(37, 37, 37, 1)
    
    var scrollBlock: ( (CGPoint) -> Void )?
    var clickBlock: ( (Bool, IndexPath) -> Void )?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StickyHorizontalCell {
    func config(datas: [String],
                fixedCount: Int,
                widths: [CGFloat],
                offsetX: CGFloat) {
        self.datas = datas
        self.fixedCount = fixedCount
        self.cellWidths = widths
        
        leftAdapter.datas = Array(datas.prefix(fixedCount))
        rightAdapter.datas = Array(datas.suffix(from: fixedCount))
        
        leftAdapter.mainView.reloadData()
        rightAdapter.mainView.reloadData()
        
        setNeedsLayout()
        layoutIfNeeded()
        rightAdapter.is_reset_offset = true
        rightAdapter.mainView.contentOffset.x = offsetX
        rightAdapter.is_reset_offset = false
    }
}

private extension StickyHorizontalCell {
    func configUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView + leftAdapter.mainView + rightAdapter.mainView
       
        leftAdapter.flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12.duobo.less, bottom: 0, right: 0)
        rightAdapter.flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12.duobo.less, bottom: 0, right: 12.duobo.less)
        
        leftAdapter.flowLayout.delegate = self
        rightAdapter.flowLayout.delegate = self
        
//        rightAdapter.mainView.isScrollEnabled = false
        
        leftAdapter.configCell = { [weak self] _, cell in
            guard let self = self else { return }
            cell.label.font = self.textFont
            cell.label.textColor = self.textColor
        }
        
        rightAdapter.configCell = { [weak self] _, cell in
            guard let self = self else { return }
            cell.label.font = self.textFont
            cell.label.textColor = self.textColor
        }
        
        leftAdapter.scrollBlock = {  [weak self] offset in
            guard let self = self else { return }
            self.scrollBlock?(offset)
        }
        
        rightAdapter.scrollBlock = {  [weak self] offset in
            guard let self = self else { return }
            self.scrollBlock?(offset)
        }
        
        leftAdapter.clickCell = { [weak self] idp in
            guard let self = self else { return }
            self.clickBlock?(true, idp)
        }
        
        rightAdapter.clickCell = { [weak self] idp in
            guard let self = self else { return }
            self.clickBlock?(false, idp)
        }
        
    }
}

extension StickyHorizontalCell: StickyHorizontalFlowLayoutDelegate {
    /// cell的宽度
    func cellWidth(for collectionView: UICollectionView, at indexPath: IndexPath) -> CGFloat {
        if collectionView == leftAdapter.mainView {
            let list = Array(cellWidths.prefix(fixedCount))
            if indexPath.item < list.count {
                return list[indexPath.item]
            }
            return 0
        } else {
            let list = Array(cellWidths.suffix(from: fixedCount))
            if indexPath.item < list.count {
                return list[indexPath.item]
            }
            return 0
        }
    }
}

extension StickyHorizontalCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = Array(cellWidths.prefix(fixedCount)).reduce(0.0) { partialResult, item in
            return partialResult + item
        } + CGFloat(fixedCount - 1) * leftAdapter.flowLayout.minimumInteritemSpacing + leftAdapter.flowLayout.sectionInset.left + leftAdapter.flowLayout.sectionInset.right
        
        leftAdapter.mainView.duobo.height = bounds.height
        leftAdapter.mainView.duobo.width = width
        
        rightAdapter.mainView.duobo.height = bounds.height
        rightAdapter.mainView.duobo.width = bounds.width - leftAdapter.mainView.duobo.width
        rightAdapter.mainView.duobo.left = leftAdapter.mainView.duobo.width
    }
}
