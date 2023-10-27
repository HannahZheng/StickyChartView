//
//  NSObject+extension.h
//  TaoYuan
//
//  Created by Ananjy2021 on 2021/9/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (extension)

//刘海屏适配常用参数
+ (BOOL)isiPhoneX;
+ (CGFloat)safeTop;
+ (CGFloat)safeBottom;

@end

NS_ASSUME_NONNULL_END
