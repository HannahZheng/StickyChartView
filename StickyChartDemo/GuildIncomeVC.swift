//
//  GuildIncomeVC.swift
//  BeiBei
//
//  Created by Han on 2023/10/24.
//

import UIKit

extension Mine.Controller {
    final class GuildIncome: UIViewController {
     
        
        private lazy var adapter = StickyListAdapter(forView: self.view)
        
        private lazy var viewModel = Mine.ViewModel.GuildIncome()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            buildUI()
            buildNav()
            bind()
            adapter.mainView.duobo.startRefresh(for: .header)
        }
    }
}

private extension Mine.Controller.GuildIncome {
    func buildUI() {
        view.backgroundColor = .white
        view + adapter.mainView
        adapter.mainView.duobo.width = view.duobo.width
        adapter.mainView.duobo.height = view.bounds.height - 44.0 - statusBarHeight
        adapter.mainView.duobo.top = 44.0 + statusBarHeight
    }
    
    func buildNav() {
      
    }
    
    func bind() {
        viewModel.forView = self.view
        
        adapter.delegate = self
       
        adapter.mainView.duobo.addHeaderRefresh { [weak self]  in
            guard let self = self else { return }
            self.viewModel.refreshData()
        }
        
        viewModel.reloadBlock = { [weak self] in
            guard let self = self else { return }
        
            self.adapter.mainView.reloadData()
            if self.viewModel.datas.count > 0 {
                self.addFooter()
            } else {
                self.adapter.mainView.mj_footer = nil
            }
            
            self.viewModel.endRefreshBlock?()
        }
        
        viewModel.errBlock = {  [weak self] err in
            guard let self = self else { return }
           
            self.adapter.mainView.mj_footer = nil
            self.adapter.mainView.reloadData()
        }
        
        viewModel.endRefreshBlock = { [weak self]  in
            guard let self = self else { return }
            self.adapter.mainView.duobo.endRefreshing(for: .header)
            self.adapter.mainView.duobo.endRefreshing(for: .footer)
            if self.viewModel.isEnd {
                self.adapter.mainView.duobo.endRefreshingWithNoMoreData()
            }
        }
        
     
    }
    
    func addFooter() {
        guard adapter.mainView.duobo.hasRefresh(for: .footer) == false else {
            return
        }
        adapter.mainView.duobo.addFooterRefresh { [weak self] in
            self?.viewModel.loadMore()
        }
    }
}

extension Mine.Controller.GuildIncome: StickyListAdapterDelegate {
    /// 标题数组
    func titles() -> [String] {
        return viewModel.titles
    }
    /// cell 数组 二维数组
    func datas() -> [[String]] {
        return viewModel.datas
    }
    /// 左侧固定不动的iten 个数
    func fixedCount() -> Int {
        return viewModel.fixedCount
    }
    /// 一行所有的item的宽度数组
    func itemWidths() -> [CGFloat] {
        return viewModel.itemWidths
    }
    /// 标题cell 样式更改
    func configTitleCell(header: StickyHorizontalCell) {
        
    }
    /// listCell 样式更改
    func configListCell(at indexPath: IndexPath, cell: StickyHorizontalCell) {
        
    }
    /// 标题 item 样式更改
    func configTitleItem(at indexPath: IndexPath, item cell: StickyCell) {
        cell.label.font = viewModel.titleFont
        cell.label.textColor = .rgba(37, 37, 37, 1)
    }
    /// cell item样式更改
    func configListItem(at indexPath: IndexPath, item cell: StickyCell) {
        cell.label.font = viewModel.cellFont
        cell.label.textColor = .rgba(37, 37, 37, 0.8)
    }
    
    /// 点击标题上的item
    func clickTitleItem(at indexPath: IndexPath, isLeft: Bool) {
        
    }
    
    /// 单行cell 点击
    func clickCell(at indexPath: IndexPath, isLeft: Bool, itemIndexPath: IndexPath) {
        guard indexPath.item < datas().count else { return }
        
    }
}
