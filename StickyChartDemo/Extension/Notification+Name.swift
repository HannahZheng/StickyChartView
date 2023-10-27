//
//  Notification+Name.swift
//  BeiBei
//
//  Created by Han on 2023/7/13.
//

import Foundation

let follow_status = "follow"
let unfollow_status = "unfollow"

extension Notification.Name {
    /// 新添加了账户等，需要重新请求用户信息 object为true 表示为登录成功需要刷新
    static let refreshUserNoti = Notification.Name("refreshUserNoti")
    /// 用户切换
    static let switchUserNoti = Notification.Name("switchUserNoti")
    /// 更新用户 用户数据已经是最新的了，不需要重新请求用户信息
    static let updateUserNoti = Notification.Name("updateUserNoti")
    /// 更改用户的关注状态 object 为 follow_status 、 unfollow_status， userInfo为用户的id
    static let updateFollowNoti = Notification.Name("updateFollowNoti")
    /// 批量关注
    static let followBatchNoti = Notification.Name("followBatchNoti")
    /// 拉黑用户的通知
    static let putUserToBlackNoti = Notification.Name("putUserToBlackNoti")
    /// 用户多个请求组合判断时使用
    static let zipDynamicDetailNoti = Notification.Name("zipDynamicDetailNoti")
    /// 动态model改变通知
    static let updateDynamicModelNoti = Notification.Name("updateDynamicModelNoti")
    ///  删除动态的通知
    static let deleteDynamicModelNoti = Notification.Name("deleteDynamicModelNoti")
    /// 发布动态成功的通知
    static let publishDynamicNoti = Notification.Name("publishDynamicNoti")
    /// 更新钱包信息通知
    static let updateBalanceInfoNoti = Notification.Name("updateWalletInfoNoti")
    /// 需要更新钱包的通知
    static let needUpdateBalanceInfoNoti = Notification.Name("needUpdateBalanceInfoNoti")
    /// 更新结算信息
    static let updateSettleInfoNoti = Notification.Name("updateSettleInfoNoti")
    /// 需要重新请求贵族中心的通知
    static let needUpateNobleCenterNoti = Notification.Name("needUpateNobleCenterNoti")
    /// 开启青少年模式的通知
    static let openYoungModeNoti = Notification.Name("openYoungModeNoti")
    /// 关闭青少年模式的通知
    static let closeYoungModeNoti = Notification.Name("closeYoungModeNoti")
    /// 更新账户安全页面的通知
    static let needUpdateAccountInfoNoti = Notification.Name("needUpdateAccountInfoNoti")
    /// 退出守护团的通知
    static let quitWatchitemNoti = Notification.Name("quitWatchitemNoti")
    /// 微信支付成功
    static let wxPaySuccessNoti = Notification.Name("wxPaySuccessNoti")
}
