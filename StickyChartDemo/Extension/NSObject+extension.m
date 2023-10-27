//
//  NSObject+extension.m
//  TaoYuan
//
//  Created by Ananjy2021 on 2021/9/16.
//

#import <UIKit/UIKit.h>
#import "NSObject+extension.h"

@implementation NSObject (extension)

+ (BOOL)isiPhoneX {
    BOOL iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return iPhoneX;
    }
    if (@available(iOS 13.0, *)) {
        if (UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
}

+ (CGFloat)safeTop {
    CGFloat top = 0;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return top;
    }
    if (@available(iOS 13.0, *)) {
        switch (UIApplication.sharedApplication.windows.firstObject.windowScene.interfaceOrientation) {
            case UIInterfaceOrientationPortrait:
                top = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.top;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                top = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.left;
                break;
            case UIInterfaceOrientationLandscapeRight:
                top = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.right;
                break;
            default:
                break;
        }
    }
    return top;
}
///刘海屏高度34,非刘海屏0
+ (CGFloat)safeBottom {
    CGFloat bottom = 0;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return bottom;
    }
    if (@available(iOS 11.0, *)) {
        switch (UIApplication.sharedApplication.windows.firstObject.windowScene.interfaceOrientation) {
            case UIInterfaceOrientationPortrait:
                bottom = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.bottom;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                bottom = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.right;
                break;
            case UIInterfaceOrientationLandscapeRight:
                bottom = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.left;
                break;
            default:
                break;
        }
    }
    return bottom;
}

@end
