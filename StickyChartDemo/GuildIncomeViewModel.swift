//
//  GuildIncomeViewModel.swift
//  BeiBei
//
//  Created by Han on 2023/10/24.
//

import UIKit

extension Mine.ViewModel {
    final class GuildIncome {
        var titles: [String] = ["时间", "星光收益", "贡献分", "特效分", "荣耀分", "公会奖励", "有效开播人数"]
        var datas: [[String]] = []
        /// 日期
        var date = Date()
        
        let titleFont = UIFont.duobo.regularFont(size: 14.duobo.less)
        let cellFont = UIFont.duobo.regularFont(size: 12.duobo.less)
        
        let fixedCount = 2
        let space = 12.duobo.less
        let min_width = 42.duobo.less
        var itemWidths: [CGFloat] = []
        
        var page = 1
        var isEnd = false
        var reloadBlock: ( () -> Void )?
        var errBlock: ( (String) -> Void )?
        var endRefreshBlock: ( () -> Void )?
        
        var forView: UIView!
        
        init() {
            // 计算宽度
            for title in titles {
                var width = title.duobo.caculateWidthWithString(font: titleFont, maxHeight: 20).width
                if width < min_width {
                    width = min_width
                }
                itemWidths.append(width)
            }
            itemWidths[0] = 68.duobo.less
        }
    }
}

extension Mine.ViewModel.GuildIncome {
    func refreshData() {
        page = 1
        isEnd = false
        loadMore()
    }
    
    func loadMore() {
        // ???: 待完善 接口请求
        if self.page == 1 {
            self.datas.removeAll()
        }
        for index in 0..<30 {
            var arr: [String] = ["2023-10-27", "431万", "1.2亿", "90万", "100万", "25万"]
            arr.append("\(index)")
            self.datas.append(arr)
        }
        
        self.page += 1
        self.isEnd = self.page > 3
        self.reloadBlock?()
        
    }
        
}
