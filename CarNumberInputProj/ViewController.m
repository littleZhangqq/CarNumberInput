//
//  ViewController.m
//  CarNumberInputProj
//
//  Created by admin on 2019/12/31.
//  Copyright © 2019 zhangqiang. All rights reserved.
//

#import "ViewController.h"
#import "CarNumberView.h"

@interface ViewController ()

ProStrong CarNumberView *carView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.carView showInputView];
    });
}

- (CarNumberView *)carView{
    if (!_carView) {
        _carView = [[CarNumberView alloc] init];
        _carView.carNumberBlock = ^(NSString * _Nonnull number) {
            NSLog(@"%@",number);
        };
    }
    return _carView;
}

@end
