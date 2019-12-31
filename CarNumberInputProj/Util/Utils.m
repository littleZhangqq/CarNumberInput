//
//  Utils.m
//  CarNumberInputProj
//
//  Created by admin on 2019/12/31.
//  Copyright © 2019 zhangqiang. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(UIImageView *)createImageWithSuper:(UIView *)view imageName:(NSString *)name mode:(UIViewContentMode)mode size:(void(^)(MASConstraintMaker *make))maker{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = mode;
    imageView.layer.masksToBounds = YES;
    if (name.length > 0) {
        imageView.image = [UIImage imageNamed:name];
    }
    [view addSubview:imageView];
    [imageView mas_makeConstraints:maker];
    return imageView;
}

+(UILabel *)createLabelWithSuper:(UIView *)view fontSize:(UIFont *)font text:(NSString *)text color:(UIColor *)color size:(void(^)(MASConstraintMaker *make))maker{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;
    label.font = font;
    [view addSubview:label];
    [label mas_makeConstraints:maker];
    return label;
}

+(UIView *)addLineForView:(UIView *)view lineColor:(UIColor *)color andMasonry:(void(^)(MASConstraintMaker *make))maker{
    UIView *line = [UIView new];
    line.backgroundColor = color;
    [view addSubview:line];
    [line mas_makeConstraints:maker];
    return line;
}

+(UIButton *)createButtonForView:(UIView *)view withButtonDetail:(void(^)( UIButton *sender))btnBlock andMasonry:(void(^)(MASConstraintMaker *make))maker andEvent:(void(^)(void))eventBlock{
    UIButton *btn = [UIButton buttonWithType:0];
    btnBlock(btn);
    [view addSubview:btn];
    [btn mas_makeConstraints:maker];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        eventBlock();
    }];
    return btn;
}

+(UIViewController *)topViewController{
    UIViewController *resultVC;
    UIViewController *ctl = [[UIApplication sharedApplication].keyWindow rootViewController];
    
    if ([ctl isKindOfClass:[UINavigationController class]]) {
        resultVC = [(UINavigationController *)ctl topViewController];
    } else if ([ctl isKindOfClass:[UITabBarController class]]) {
        resultVC = [(UITabBarController *)ctl selectedViewController];
    } else {
        resultVC = ctl;
    }
    
    while (resultVC.presentedViewController) {
        resultVC = resultVC.presentedViewController;
    }
    return resultVC;
}


@end
