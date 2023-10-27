//
//  ScrollView+Refresh.swift
//  MobileScanKing
//
//  Created by Han on 2022/3/18.
//

import UIKit
import MJRefresh

extension UIScrollView {
    enum RefreshStyle {
        case header, footer
    }
}

extension Duobo where Object: UIScrollView {
    func addRefresh(for style: UIScrollView.RefreshStyle, block: @escaping () -> Void) {
        switch style {
        case .header:
            object.mj_header = MJRefreshNormalHeader(refreshingBlock: block)
        case .footer:
            object.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: block)
        }
    }
    
    func addHeaderRefresh(with config: ((MJRefreshNormalHeader) -> Void)? = nil, block: @escaping () -> Void) {
        let header = MJRefreshNormalHeader(refreshingBlock: block)
        header.stateLabel?.font = UIFont.duobo.regularFont(size: 13.duobo.less)
        header.lastUpdatedTimeLabel?.font = UIFont.duobo.regularFont(size: 13.duobo.less)
        config?(header)
        object.mj_header = header
    }
    
    func addFooterRefresh(with config: ((MJRefreshAutoNormalFooter) -> Void)? = nil, block: @escaping () -> Void) {
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: block)
        footer.setTitle("哎呀.已经到底了～", for: .noMoreData)
        footer.stateLabel?.font = UIFont.duobo.regularFont(size: 13.duobo.less)
        config?(footer)
        object.mj_footer = footer
    }
    
    func startRefresh(for style: UIScrollView.RefreshStyle) {
        switch style {
        case .header:
            guard let header = object.mj_header else { return }
            if header.isRefreshing {
                return
            }
            header.beginRefreshing()
        case .footer:
            guard let footer = object.mj_footer else { return }
            if footer.isRefreshing {
                return
            }
            footer.beginRefreshing()
        }
    }
    
    func removeRefresh(for style: UIScrollView.RefreshStyle) {
        switch style {
        case .header:
            object.mj_header = nil
        case .footer:
            object.mj_footer = nil
        }
    }
    
    func endRefreshing(for style: UIScrollView.RefreshStyle) {
        switch style {
        case .header:
            object.mj_header?.endRefreshing()
        default:
            object.mj_footer?.endRefreshing()
        }
    }
    
    func endRefreshingWithNoMoreData(showFooterStateLabel: Bool = true) {
        if let v = object.mj_footer as? MJRefreshAutoStateFooter {
            v.stateLabel?.isHidden = !showFooterStateLabel
        }
        object.mj_footer?.endRefreshingWithNoMoreData()
    }
    
    func resetNoMoreData() {
        object.mj_footer?.resetNoMoreData()
    }
    
    func hasRefresh(for style: UIScrollView.RefreshStyle) -> Bool {
        switch style {
        case .header:
            return object.mj_header != nil
        case .footer:
            return object.mj_footer != nil
        }
    }
}
