//
//  CarNumberCollectionViewCell.h
//  yqjy
//
//  Created by admin on 2019/12/25.
//  Copyright © 2019 易起. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarNumberLetterCollectionCell : UICollectionViewCell

ProCopy void(^clickKeyboardBlock)(void);
-(void)updateCellWith:(NSString *)title;

@end

@interface CarNumberProvinceCollectionCell : UICollectionViewCell

ProCopy void(^clickProvinceBlock)(NSString *province);

-(void)updateCellWith:(NSDictionary *)dic;

@end

@interface CarNumberCollectionViewCell : UICollectionViewCell

@end

NS_ASSUME_NONNULL_END
