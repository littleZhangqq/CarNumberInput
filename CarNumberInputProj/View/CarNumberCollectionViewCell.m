//
//  CarNumberCollectionViewCell.m
//  yqjy
//
//  Created by admin on 2019/12/25.
//  Copyright © 2019 易起. All rights reserved.
//

#import "CarNumberCollectionViewCell.h"

@interface CarNumberLetterCollectionCell()

ProStrong UIButton *mainButton;

@end

@implementation CarNumberLetterCollectionCell

-(void)createMainView{
    if (_mainButton) {
        return;
    }
    self.contentView.backgroundColor = COLOR(clearColor);
    UIView *sView = [UIView new];
    sView.backgroundColor = COLOR(whiteColor);
    sView.layer.shadowColor = ColorRGB(150, 150, 150).CGColor;
    sView.layer.shadowOffset = CGSizeMake(0, 3);
    sView.layer.shadowOpacity = 0.7;
    sView.layer.shadowRadius = 2;
    sView.layer.cornerRadius = 4;
    [self.contentView addSubview:sView];
    
    [sView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-W(8));
        make.left.equalTo(W(2));
        make.right.equalTo(-W(2));
        make.height.equalTo(H(5));
    }];
    
    _mainButton = [Utils createButtonForView:self.contentView withButtonDetail:^(UIButton * _Nonnull sender) {
        sender.layer.cornerRadius = 5;
        [sender setTitleColor:COLOR(blackColor) forState:0];
        sender.titleLabel.font = FONT_CUSTOM(17);
        [sender setBackgroundImage:[UIImage imageWithColor:COLOR(whiteColor)] forState:0];
        sender.layer.masksToBounds = YES;
        [sender setBackgroundImage:[UIImage imageWithColor:ColorRGB(165,172,180)] forState:UIControlStateHighlighted];
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(W(7), W(1), W(7), W(1)));
    } andEvent:^{
        if (self.clickKeyboardBlock) {
            self.clickKeyboardBlock();
        }
    }];
}

-(void)updateCellWith:(NSString *)title{
    [self createMainView];
    [_mainButton setTitle:title forState:0];
}


@end

@interface CarNumberProvinceCollectionCell ()

ProStrong UIButton *mainButton;

@end


@implementation CarNumberProvinceCollectionCell

-(void)createMainView{
    if (_mainButton) {
        return;
    }
    _mainButton = [Utils createButtonForView:self.contentView withButtonDetail:^(UIButton * _Nonnull sender) {
        sender.layer.cornerRadius = 3;
        sender.layer.masksToBounds = YES;
        [sender setTitleColor:COLOR(blackColor) forState:0];
        [sender setTitleColor:COLOR(whiteColor) forState:UIControlStateSelected];
        sender.titleLabel.font = FONTSize(16);
        [sender setBackgroundImage:[UIImage imageWithColor:ColorRGB(243,251,248)] forState:0];
        [sender setBackgroundImage:[UIImage imageWithColor:ColorRGB(8,204,125)] forState:UIControlStateSelected];
        sender.layer.borderColor = ColorRGB(200, 200, 200).CGColor;
        sender.layer.borderWidth = 0.8;
        sender.adjustsImageWhenHighlighted = NO;
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(1, 1, 1, 1));
    } andEvent:^{
        _mainButton.selected = YES;
        if (self.clickProvinceBlock) {
            self.clickProvinceBlock(_mainButton.currentTitle);
        }
    }];
}

-(void)updateCellWith:(NSDictionary *)dic{
    [self createMainView];
    [_mainButton setTitle:dic[@"str"] forState:0];
    _mainButton.selected = [dic[@"select"] boolValue];
    if ([dic[@"select"] boolValue]) {
        _mainButton.layer.borderWidth = 0;
    }else{
        _mainButton.layer.borderColor = ColorRGB(200, 200, 200).CGColor;
        _mainButton.layer.borderWidth = 0.8;
    }
}

@end

@implementation CarNumberCollectionViewCell

@end
