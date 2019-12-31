//
//  Prefix.h
//  CarNumberInputProj
//
//  Created by admin on 2019/12/31.
//  Copyright © 2019 zhangqiang. All rights reserved.
//

#ifndef Prefix_h
#define Prefix_h

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND

#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "Utils.h"
#import "UIImage+HQImage.h"

#define LocalImage(a)  [UIImage imageNamed:a]
#define ProStrong @property (nonatomic, strong)
#define ProUnsafe @property (nonatomic, unsafe_unretained)
#define ProWeak @property (nonatomic, weak)
#define ProCopy @property (nonatomic, copy)
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF    __weak typeof(self) weakSelf = self;
#define FONTSize(i) [UIFont systemFontOfSize:i]
#define FONT_BOLD(a) [UIFont boldSystemFontOfSize:a]
#define FONT_SC(a) [UIFont fontWithName:@"PingFang SC" size:a]
#define FONT_PingFangBold(a) [UIFont fontWithName:@"PingFangSC-Semibold" size:a]
#define FONT_CUSTOM(a) [UIFont fontWithName:@"PingFang-SC-Medium" size:a]
#define FONT_Regular(a) [UIFont fontWithName:@"PingFang-SC-Regular" size:a]

#define COLOR(Costom)         ([UIColor Costom])
#define ColorRGB(R,G,B)     [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1.0f]
#define ColorRGBA(R,G,B,A)     [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

#define kKeyWindow          [UIApplication sharedApplication].keyWindow

#define H(a) (a*(screenHeight-34))/667.0
#define W(a) (screenWidth*(a))/375.0


#endif /* Prefix_h */
