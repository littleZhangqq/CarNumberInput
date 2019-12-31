//
//  CarNumberView.h
//  yqjy
//
//  Created by admin on 2019/12/24.
//  Copyright © 2019 易起. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum: NSUInteger{
    CarNumberInputCurrentTypeProvince = 0,
    CarNumberInputCurrentTypeCity,
    CarNumberInputCurrentTypeOther
}CarNumberInputCurrentType;

typedef enum: NSUInteger{
    CarTypeTraditional = 0,//汽油车
    CarTypeNewEnergy,//新能源车(6位车牌号)
}CarType;

NS_ASSUME_NONNULL_BEGIN

@interface NumberLetterView : UIView

ProCopy void(^numberLetterBlock)(NSString *str);
ProCopy void(^deleteBlock)(void);

@end

@interface OnlyLetterView : UIView

ProCopy void(^onlyLetterBlock)(NSString *str);
ProCopy void(^deleteBlock)(void);

@end

@interface NumberProvinceView : UIView

ProCopy void(^provinceBlock)(NSString *str);

@end

@interface CarNumberView : UIView

ProUnsafe CarNumberInputCurrentType currentType;
ProUnsafe CarType carType;
ProCopy void(^carNumberBlock)(NSString *number);
ProCopy void(^panBackNaviBlock)(void);

-(void)showInputView;
-(void)dismissInputView;


@end

NS_ASSUME_NONNULL_END
