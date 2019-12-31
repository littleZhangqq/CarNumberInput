//
//  Utils.h
//  CarNumberInputProj
//
//  Created by admin on 2019/12/31.
//  Copyright © 2019 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

+(UILabel *)createLabelWithSuper:(UIView *)view fontSize:(UIFont *)font text:(NSString *)text color:(UIColor *)color size:(void(^)(MASConstraintMaker *make))maker;
+(UIImageView *)createImageWithSuper:(UIView *)view imageName:(NSString *)name mode:(UIViewContentMode)mode size:(void(^)(MASConstraintMaker *make))maker;
+(UIView *)addLineForView:(UIView *)view lineColor:(UIColor *)color andMasonry:(void(^)(MASConstraintMaker *make))maker;
+(UIButton *)createButtonForView:(UIView *)view withButtonDetail:(void(^)( UIButton *sender))btnBlock andMasonry:(void(^)(MASConstraintMaker *make))maker andEvent:(void(^)(void))eventBlock;
+(UIViewController *)topViewController;

@end

NS_ASSUME_NONNULL_END
