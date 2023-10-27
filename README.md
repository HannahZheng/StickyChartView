# StickyChartView

运行代码切换到dev分支

使用方式见 Mine.Controller.GuildIncome

private lazy var adapter = StickyListAdapter(forView: self.view)
 view + adapter.mainView
 adapter.delegate = self


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
