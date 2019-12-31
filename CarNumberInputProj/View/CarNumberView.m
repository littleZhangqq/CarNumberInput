//
//  CarNumberView.m
//  yqjy
//
//  Created by admin on 2019/12/24.
//  Copyright © 2019 易起. All rights reserved.
//

#import "CarNumberView.h"
#import "CarNumberCollectionViewCell.h"

#pragma mark 字母数字键盘
@interface NumberLetterView ()<UICollectionViewDelegate,UICollectionViewDataSource>

ProStrong UICollectionView *topCollectionView;
ProStrong UICollectionView *centerCollectionView;
ProStrong UICollectionView *btmCollectionView;
ProStrong UIButton *deleteButton;
ProStrong UIButton *doneButton;
ProStrong NSMutableArray *topArray;
ProStrong NSMutableArray *centerArray;
ProStrong NSMutableArray *btmArray;

@end

@implementation NumberLetterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CarNumber" ofType:@"plist"]];
        self.topArray = [NSMutableArray arrayWithArray:dic[@"Number"]];
        [self.topArray addObjectsFromArray:dic[@"FirstLetter"]];
        self.centerArray = [NSMutableArray arrayWithArray:dic[@"SecondLetter"]];
        self.btmArray = [NSMutableArray arrayWithArray:dic[@"ThirdLetter"]];
        [self createMainView];
    }
    return self;
}

-(void)createMainView{
    self.backgroundColor = ColorRGBA(205,208,213,0.95);
    UIView *topView = [UIView new];
    topView.backgroundColor = ColorRGBA(223, 223, 223,0.9);
    [self addSubview:topView];
    
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(H(40));
    }];
    
    [Utils createButtonForView:topView withButtonDetail:^(UIButton * _Nonnull sender) {
        [sender setTitle:@"完成" forState:0];
        [sender setTitleColor:ColorRGB(0, 136, 255) forState:0];
        sender.titleLabel.font = FONT_CUSTOM(16);
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(topView);
        make.right.equalTo(-W(15));
    } andEvent:^{
        [self dismiss];
    }];
    
    CGFloat ratio =  (86.0/63);  //按键的高宽比
    CGFloat width = ((screenWidth-W(27)-W(6)) /10); //按键的宽
    CGFloat height = width*ratio;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, height+H(10));
    layout.sectionInset = UIEdgeInsetsMake(0, W(3), 0, W(3));
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _topCollectionView.delegate = self;
    _topCollectionView.dataSource = self;
    _topCollectionView.backgroundColor = COLOR(clearColor);
    _topCollectionView.scrollEnabled = NO;
    [_topCollectionView registerClass:[CarNumberLetterCollectionCell class] forCellWithReuseIdentifier:@"topCell"];
    [self addSubview:_topCollectionView];
    
    [_topCollectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(topView.bottom).offset(H(5));
        make.height.equalTo((height+10)*2);
    }];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.itemSize = CGSizeMake(width, height+H(10));
    layout1.sectionInset = UIEdgeInsetsMake(0, W(25), 0, W(25));
    layout1.minimumInteritemSpacing = 0;
    layout1.minimumInteritemSpacing = (screenWidth-W(50)-width*9)/8;
    layout1.minimumLineSpacing = 0;
    layout1.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _centerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout1];
    _centerCollectionView.delegate = self;
    _centerCollectionView.dataSource = self;
    _centerCollectionView.scrollEnabled = NO;
    _centerCollectionView.backgroundColor = COLOR(clearColor);
    [_centerCollectionView registerClass:[CarNumberLetterCollectionCell class] forCellWithReuseIdentifier:@"centerCell"];
    [self addSubview:_centerCollectionView];
    
    [_centerCollectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(height+10);
        make.top.equalTo(_topCollectionView.bottom);
    }];
    
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.itemSize = CGSizeMake(width, height+H(10));
    layout2.sectionInset = UIEdgeInsetsMake(0, W(50), 0, W(50));
    layout2.minimumInteritemSpacing = (screenWidth-W(100)-width*7)/6;
    layout2.minimumLineSpacing = 0;
    layout2.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _btmCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout2];
    _btmCollectionView.delegate = self;
    _btmCollectionView.dataSource = self;
    _btmCollectionView.scrollEnabled = NO;
    _btmCollectionView.backgroundColor = COLOR(clearColor);
    [_btmCollectionView registerClass:[CarNumberLetterCollectionCell class] forCellWithReuseIdentifier:@"btmCell"];
    [self addSubview:_btmCollectionView];
    
    [_btmCollectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(height+10);
        make.top.equalTo(_centerCollectionView.bottom);
    }];
    
    UIView *deleteView = [UIView new];
    deleteView.backgroundColor = ColorRGB(165,172,180);
    deleteView.layer.shadowColor = ColorRGB(150, 150, 150).CGColor;
    deleteView.layer.shadowOffset = CGSizeMake(0, 3);
    deleteView.layer.shadowOpacity = 1;
    deleteView.layer.shadowRadius = 3;
    deleteView.layer.cornerRadius = 4;
    [self addSubview:deleteView];
    
    [deleteView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_btmCollectionView).offset(-W(7));
        make.right.equalTo(-W(5));
        make.size.equalTo(CGSizeMake(W(40)-W(4),10));
    }];
    
    _deleteButton = [Utils createButtonForView:self withButtonDetail:^(UIButton * _Nonnull sender) {
        sender.backgroundColor = ColorRGB(165,172,180);
        [sender setImage:LocalImage(@"keyboard_delete") forState:0];
        sender.layer.cornerRadius = 4;
        sender.layer.masksToBounds = YES;
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.bottom.equalTo(_btmCollectionView).offset(-W(7));
        make.right.equalTo(-W(5));
        make.size.equalTo(CGSizeMake(W(40)-W(4), height+H(10)-W(18)));
    } andEvent:^{
        if (self.deleteBlock) {
            self.deleteBlock();
        }
    }];
    
    UIView *doneView = [UIView new];
    doneView.backgroundColor = ColorRGB(165,172,180);
    doneView.layer.shadowColor = ColorRGB(150, 150, 150).CGColor;
    doneView.layer.shadowOffset = CGSizeMake(0, 3);
    doneView.layer.shadowOpacity = 1;
    doneView.layer.shadowRadius = 3;
    doneView.layer.cornerRadius = 4;
    [self addSubview:doneView];
    
    [doneView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_btmCollectionView).offset(-W(7));
        make.left.equalTo(W(5));
        make.size.equalTo(CGSizeMake(W(40)-W(4),10));
    }];
    
    _doneButton = [Utils createButtonForView:self withButtonDetail:^(UIButton * _Nonnull sender) {
        sender.backgroundColor = ColorRGB(165,172,180);
        [sender setImage:LocalImage(@"keyboard_done") forState:0];
        sender.layer.cornerRadius = 4;
        sender.layer.masksToBounds = YES;
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.bottom.equalTo(_btmCollectionView).offset(-W(7));
        make.left.equalTo(W(5));
        make.size.equalTo(CGSizeMake(W(40)-W(4), height+H(10)-W(18)));
    } andEvent:^{
        
    }];
}

-(void)dismiss{
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.top).offset(screenHeight);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.superview layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.topCollectionView) {
        return self.topArray.count;
    }else if (collectionView == self.centerCollectionView){
        return  self.centerArray.count;
    }else{
        return self.btmArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CarNumberLetterCollectionCell *cell;
    NSString *string;
    if (collectionView == self.topCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        string = self.topArray[indexPath.item];
    }else if (collectionView == self.centerCollectionView){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"centerCell" forIndexPath:indexPath];
        string = self.centerArray[indexPath.item];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"btmCell" forIndexPath:indexPath];
        string = self.btmArray[indexPath.item];
    }
    [cell updateCellWith:string];
    cell.clickKeyboardBlock = ^{
        if (self.numberLetterBlock) {
            self.numberLetterBlock(string);
        }
    };
    return cell;
}

@end

#pragma mark 纯字母键盘
@interface OnlyLetterView ()<UICollectionViewDelegate,UICollectionViewDataSource>

ProStrong UICollectionView *topCollectionView;
ProStrong UICollectionView *centerCollectionView;
ProStrong UICollectionView *btmCollectionView;
ProStrong UIButton *deleteButton;
ProStrong UIButton *doneButton;
ProStrong NSMutableArray *topArray;
ProStrong NSMutableArray *centerArray;
ProStrong NSMutableArray *btmArray;

@end

@implementation OnlyLetterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CarNumber" ofType:@"plist"]];
        self.topArray = [NSMutableArray arrayWithArray:dic[@"FirstLetter"]];
        self.centerArray = [NSMutableArray arrayWithArray:dic[@"SecondLetter"]];
        self.btmArray = [NSMutableArray arrayWithArray:dic[@"ThirdLetter"]];
        [self createMainView];
    }
    return self;
}

-(void)createMainView{
    self.backgroundColor = ColorRGBA(205,208,213,0.95);
    UIView *topView = [UIView new];
    topView.backgroundColor = ColorRGBA(223, 223, 223,0.9);
    [self addSubview:topView];
    
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(H(40));
    }];
    
    [Utils createButtonForView:topView withButtonDetail:^(UIButton * _Nonnull sender) {
        [sender setTitle:@"完成" forState:0];
        [sender setTitleColor:ColorRGB(0, 136, 255) forState:0];
        sender.titleLabel.font = FONTSize(16);
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.centerY.equalTo(topView);
        make.right.equalTo(-W(15));
    } andEvent:^{
        [self dismiss];
    }];
    
    CGFloat ratio =  (86.0/63);  //按键的高宽比
    CGFloat width = ((screenWidth-W(27)-W(6)) /10); //按键的宽
    CGFloat height = width*ratio;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, height+H(10));
    layout.sectionInset = UIEdgeInsetsMake(0, W(3), 0, W(3));
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _topCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _topCollectionView.delegate = self;
    _topCollectionView.dataSource = self;
    _topCollectionView.backgroundColor = COLOR(clearColor);
    _topCollectionView.scrollEnabled = NO;
    [_topCollectionView registerClass:[CarNumberLetterCollectionCell class] forCellWithReuseIdentifier:@"topCell"];
    [self addSubview:_topCollectionView];
    
    [_topCollectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(topView.bottom).offset(H(5));
        make.height.equalTo(height+10);
    }];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.itemSize = CGSizeMake(width, height+H(10));
    layout1.sectionInset = UIEdgeInsetsMake(0, W(25), 0, W(25));
    layout1.minimumInteritemSpacing = 0;
    layout1.minimumInteritemSpacing = (screenWidth-W(50)-width*9)/8;
    layout1.minimumLineSpacing = 0;
    layout1.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _centerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout1];
    _centerCollectionView.delegate = self;
    _centerCollectionView.dataSource = self;
    _centerCollectionView.scrollEnabled = NO;
    _centerCollectionView.backgroundColor = COLOR(clearColor);
    [_centerCollectionView registerClass:[CarNumberLetterCollectionCell class] forCellWithReuseIdentifier:@"centerCell"];
    [self addSubview:_centerCollectionView];
    
    [_centerCollectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(height+10);
        make.top.equalTo(_topCollectionView.bottom);
    }];
    
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc] init];
    layout2.itemSize = CGSizeMake(width, height+H(10));
    layout2.sectionInset = UIEdgeInsetsMake(0, W(50), 0, W(50));
    layout2.minimumInteritemSpacing = (screenWidth-W(100)-width*7)/6;
    layout2.minimumLineSpacing = 0;
    layout2.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _btmCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout2];
    _btmCollectionView.delegate = self;
    _btmCollectionView.dataSource = self;
    _btmCollectionView.scrollEnabled = NO;
    _btmCollectionView.backgroundColor = COLOR(clearColor);
    [_btmCollectionView registerClass:[CarNumberLetterCollectionCell class] forCellWithReuseIdentifier:@"btmCell"];
    [self addSubview:_btmCollectionView];
    
    [_btmCollectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(height+10);
        make.top.equalTo(_centerCollectionView.bottom);
    }];
    
    UIView *deleteView = [UIView new];
    deleteView.backgroundColor = ColorRGB(165,172,180);
    deleteView.layer.shadowColor = ColorRGB(150, 150, 150).CGColor;
    deleteView.layer.shadowOffset = CGSizeMake(0, 3);
    deleteView.layer.shadowOpacity = 1;
    deleteView.layer.shadowRadius = 3;
    deleteView.layer.cornerRadius = 4;
    [self addSubview:deleteView];
    
    [deleteView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_btmCollectionView).offset(-W(7));
        make.right.equalTo(-W(5));
        make.size.equalTo(CGSizeMake(W(40)-W(4),10));
    }];
    
    _deleteButton = [Utils createButtonForView:self withButtonDetail:^(UIButton * _Nonnull sender) {
        sender.backgroundColor = ColorRGB(165,172,180);
        [sender setImage:LocalImage(@"keyboard_delete") forState:0];
        sender.layer.cornerRadius = 4;
        sender.layer.masksToBounds = YES;
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.bottom.equalTo(_btmCollectionView).offset(-W(7));
        make.right.equalTo(-W(5));
        make.size.equalTo(CGSizeMake(W(40)-W(4), height+H(10)-W(18)));
    } andEvent:^{
        if (self.deleteBlock) {
            self.deleteBlock();
        }
    }];
    
    UIView *doneView = [UIView new];
    doneView.backgroundColor = ColorRGB(165,172,180);
    doneView.layer.shadowColor = ColorRGB(150, 150, 150).CGColor;
    doneView.layer.shadowOffset = CGSizeMake(0, 3);
    doneView.layer.shadowOpacity = 1;
    doneView.layer.shadowRadius = 3;
    doneView.layer.cornerRadius = 4;
    [self addSubview:doneView];
    
    [doneView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_btmCollectionView).offset(-W(7));
        make.left.equalTo(W(5));
        make.size.equalTo(CGSizeMake(W(40)-W(4),10));
    }];
    
    _doneButton = [Utils createButtonForView:self withButtonDetail:^(UIButton * _Nonnull sender) {
        sender.backgroundColor = ColorRGB(165,172,180);
        [sender setImage:LocalImage(@"keyboard_done") forState:0];
        sender.layer.cornerRadius = 4;
        sender.layer.masksToBounds = YES;
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.bottom.equalTo(_btmCollectionView).offset(-W(7));
        make.left.equalTo(W(5));
        make.size.equalTo(CGSizeMake(W(40)-W(4), height+H(10)-W(18)));
    } andEvent:^{
        
    }];
}

-(void)dismiss{
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.top).offset(screenHeight);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.superview layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.topCollectionView) {
        return self.topArray.count;
    }else if (collectionView == self.centerCollectionView){
        return  self.centerArray.count;
    }else{
        return self.btmArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CarNumberLetterCollectionCell *cell;
    NSString *string;
    if (collectionView == self.topCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        string = self.topArray[indexPath.item];
    }else if (collectionView == self.centerCollectionView){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"centerCell" forIndexPath:indexPath];
        string = self.centerArray[indexPath.item];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"btmCell" forIndexPath:indexPath];
        string = self.btmArray[indexPath.item];
    }
    [cell updateCellWith:string];
    cell.clickKeyboardBlock = ^{
        if (self.onlyLetterBlock) {
            self.onlyLetterBlock(string);
        }
    };
    return cell;
}

@end

#pragma mark 省份键盘
@interface NumberProvinceView ()<UICollectionViewDelegate,UICollectionViewDataSource>

ProStrong UICollectionView *collectionView;
ProStrong NSMutableArray *dataArray;

@end

@implementation NumberProvinceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CarNumber" ofType:@"plist"]];
        NSArray *array = dic[@"Province"];
        self.dataArray = [NSMutableArray array];
        for (NSInteger i = 0; i<array.count; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"str"] = array[i];
            dic[@"select"] = @(NO);
            [self.dataArray addObject:dic];
        }
        [self createMainView];
    }
    return self;
}

-(void)createMainView{
    self.backgroundColor = ColorRGB(245, 245, 245);
    UIView *topView = [UIView new];
    [self addSubview:topView];
    
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(H(30));
    }];
    
    [Utils createButtonForView:topView withButtonDetail:^(UIButton * _Nonnull sender) {
        [sender setImage:LocalImage(@"expand_province") forState:0];
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.centerX.top.bottom.equalTo(topView);
        make.width.equalTo(W(50));
    } andEvent:^{
        [self dismissProvinceView];
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(W(45), W(45));
    layout.minimumInteritemSpacing = W(5);
    layout.minimumLineSpacing = W(H(315)-W(45)*5-W(20)-H(30)-H(20))/4;
    layout.sectionInset = UIEdgeInsetsMake(W(10), W(10), W(10), W(10));
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = COLOR(whiteColor);
    [_collectionView registerClass:[CarNumberProvinceCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_collectionView];
    
    [_collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(topView.bottom);
    }];
}

-(void)dismissProvinceView{
    [self updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.top).offset(screenHeight);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.superview layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CarNumberProvinceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateCellWith:self.dataArray[indexPath.item]];
    cell.clickProvinceBlock = ^(NSString *title){
        for (NSMutableDictionary *dic in self.dataArray) {
            dic[@"select"] = @(NO);
            if ([dic[@"str"] isEqualToString:title]) {
                dic[@"select"] = @(YES);
            }
        }
        [collectionView reloadData];
        if (self.provinceBlock) {
            self.provinceBlock(title);
        }
    };
    return cell;
}

@end

@interface CarNumberView ()

ProStrong UIView *bgView;
ProStrong NumberProvinceView *provinceView;
ProStrong OnlyLetterView *onlyLetterView;
ProStrong NumberLetterView *numberLetterView;
ProUnsafe NSInteger currentIndex;
ProUnsafe NSInteger total;
ProUnsafe BOOL isRight;

@end

#pragma mark 车牌输入  整合了上面的几个view
@implementation CarNumberView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createMainView];
        self.currentType = 999;
    }
    return self;
}

-(void)createMainView{
    self.backgroundColor = ColorRGBA(0, 0, 0, 0.4);
    [kKeyWindow addSubview:self];
    
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(kKeyWindow);
    }];
    
    _bgView = [UIView new];
    _bgView.backgroundColor = COLOR(whiteColor);
    _bgView.layer.cornerRadius = 5;
    [self addSubview:_bgView];
    
    [_bgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(W(340), H(173)));
        make.top.equalTo(self.top).offset(screenHeight);
    }];
    
    [Utils createLabelWithSuper:_bgView fontSize:FONT_BOLD(16) text:@"填写车牌号" color:ColorRGB(51, 51, 51) size:^(MASConstraintMaker * _Nonnull make) {
        make.centerX.equalTo(_bgView);
        make.top.equalTo(H(15));
    }];
    
    [Utils addLineForView:_bgView lineColor:ColorRGB(235, 235, 235) andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.left.equalTo(W(15));
        make.right.equalTo(-W(15));
        make.top.equalTo(H(50));
        make.height.equalTo(0.8);
    }];
    
    UILabel *numberLabel = [Utils createLabelWithSuper:_bgView fontSize:FONTSize(16) text:@"车牌号" color:ColorRGB(51, 51, 51) size:^(MASConstraintMaker * _Nonnull make) {
        make.left.equalTo(W(14));
        make.top.equalTo(H(75));
    }];
    
    UIButton *lastButton;
    for (NSInteger i = 0; i<8; i++) {
        __block UIButton *btn = [Utils createButtonForView:_bgView withButtonDetail:^(UIButton * _Nonnull sender) {
            sender.layer.cornerRadius = 3;
            sender.layer.borderWidth = 0.7;
            sender.layer.borderColor = ColorRGB(177, 177, 177).CGColor;
            sender.layer.masksToBounds = YES;
            sender.backgroundColor = COLOR(whiteColor);
            sender.titleLabel.font = FONTSize(18);
            [sender setTitle:@"" forState:0];
            sender.tag = 1000+i;
            if (i == 0) {
                [sender setBackgroundImage:LocalImage(@"province_bg") forState:0];
                [sender setTitleColor:COLOR(whiteColor) forState:0];
            }else if (i == 7){
                [sender setBackgroundImage:LocalImage(@"newEnergy_bg") forState:0];
                [sender setTitleColor:COLOR(blackColor) forState:0];
            }else{
                [sender setTitleColor:COLOR(blackColor) forState:0];
            }
        } andMasonry:^(MASConstraintMaker * _Nonnull make) {
            if (lastButton) {
                if (i == 2) {
                    make.left.equalTo(lastButton.right).offset(W(12));
                }else{
                    make.left.equalTo(lastButton.right).offset(W(2));
                }
            }else{
                make.left.equalTo(numberLabel.right).offset(W(10));
            }
            if (i == 0) {
                make.width.equalTo(W(37));
            }else{
                make.width.equalTo(W(28));
            }
            make.centerY.equalTo(numberLabel);
            make.height.equalTo(H(32));
        } andEvent:^{
            if (i == 0) {
                self.currentType = CarNumberInputCurrentTypeProvince;
            }else if(i == 1){
                self.currentType = CarNumberInputCurrentTypeCity;
            }else{
                self.currentType = CarNumberInputCurrentTypeOther;
            }
            if (i == 7) {
                self.carType = CarTypeNewEnergy;
            }
            self.currentIndex = i;
            //当前点击的按钮给个颜色框 提示用户正在点击的哪个位置
            for (NSInteger i = 0; i<self.total; i++) {
                UIButton *btn1 = [self viewWithTag:1000+i];
                if ( i != 0 && i != _currentIndex) {
                    btn1.layer.borderColor = ColorRGB(177, 177, 177).CGColor;
                }else if (i != 0 && i == _currentIndex){
                    btn1.layer.borderColor = ColorRGB(100, 100, 100).CGColor;
                }
            }
        }];
        
        if (i == 2) {
            UIView *pView = [UIView new];
            [_bgView addSubview:pView];
            
            [pView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.right);
                make.right.equalTo(btn.left);
                make.top.bottom.equalTo(btn);
            }];
            
            UIView *point = [UIView new];
            point.backgroundColor = COLOR(blackColor);
            point.layer.cornerRadius = 3;
            point.layer.masksToBounds = YES;
            [pView addSubview:point];
            
            [point makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(CGSizeMake(6, 6));
                make.center.equalTo(pView);
            }];
        }
        lastButton = btn;
    }
    
     [Utils createButtonForView:_bgView withButtonDetail:^(UIButton * _Nonnull sender) {
        sender.backgroundColor = ColorRGB(34, 34, 34);
        [sender setTitle:@"确认" forState:0];
        sender.titleLabel.font = FONTSize(16);
        [sender setTitleColor:COLOR(whiteColor) forState:0];
        sender.layer.cornerRadius = 3;
    } andMasonry:^(MASConstraintMaker * _Nonnull make) {
        make.centerX.equalTo(_bgView);
        make.top.equalTo(lastButton.bottom).offset(H(17));
        make.size.equalTo(CGSizeMake(W(112), H(40)));
    } andEvent:^{
        
        NSMutableString *number = [NSMutableString string];
        for (NSInteger i = 0; i<self.total; i++) {
            UIButton *btn = [self viewWithTag:1000+i];
            if (btn.currentTitle.length == 0) {
                NSLog(@"请将车牌号填写完整");
                return ;
            }
            [number appendString:btn.currentTitle];
        }
        if (self.carNumberBlock) {
            self.carNumberBlock(number);
        }
        [self dismissInputView];
    }];
    self.provinceView.hidden = YES;
    self.onlyLetterView.hidden = YES;
    self.numberLetterView.hidden = YES;
}

- (NumberProvinceView *)provinceView{
    if (!_provinceView) {
        _provinceView = [[NumberProvinceView alloc] init];
        [self addSubview:_provinceView];
        
        [_provinceView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.top).offset(screenHeight);
            make.height.equalTo(H(300));
        }];
        
        WEAK_SELF;
        _provinceView.provinceBlock = ^(NSString * _Nonnull str) {
            [weakSelf receveNewInputCharacter:weakSelf.provinceView string:str];
        };
    }
    return _provinceView;
}

- (OnlyLetterView *)onlyLetterView{
    if (!_onlyLetterView) {
        _onlyLetterView = [[OnlyLetterView alloc] init];
        [self addSubview:_onlyLetterView];
        
        [_onlyLetterView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.top).offset(screenHeight);
            make.height.equalTo(H(220));
        }];
        
        WEAK_SELF;
        _onlyLetterView.onlyLetterBlock = ^(NSString * _Nonnull str) {
            [weakSelf receveNewInputCharacter:weakSelf.onlyLetterView string:str];
        };
        
        _onlyLetterView.deleteBlock = ^{
            [weakSelf deleteKeyboardClick];
        };
    }
    return _onlyLetterView;
}

- (NumberLetterView *)numberLetterView{
    if (!_numberLetterView) {
        _numberLetterView = [[NumberLetterView alloc] init];
        [self addSubview:_numberLetterView];
        
        [_numberLetterView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.top).offset(screenHeight);
            make.height.equalTo(H(275));
        }];
        
        WEAK_SELF;
        _numberLetterView.numberLetterBlock = ^(NSString * _Nonnull str) {
            [weakSelf receveNewInputCharacter:weakSelf.numberLetterView string:str];
        };
        
        _numberLetterView.deleteBlock = ^{
            [weakSelf deleteKeyboardClick];
        };
    }
    return _numberLetterView;
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    if (_currentIndex < 0) {
        _currentIndex = 0;
    }
    if (_currentIndex >= self.total - 1) {
        _currentIndex = self.total-1;
    }
    
    if (_currentIndex == 0){
        self.currentType = CarNumberInputCurrentTypeProvince;
    }else if (_currentIndex == 1) {
        self.currentType = CarNumberInputCurrentTypeCity;
    }else{
        self.currentType = CarNumberInputCurrentTypeOther;
    }
}

-(void)receveNewInputCharacter:(UIView *)view string:(NSString *)str{
    if (_carType == CarTypeNewEnergy && _currentIndex == self.total-1) {
        UIButton *btn = [self viewWithTag:1000+_currentIndex];
        [btn setBackgroundImage:LocalImage(@"") forState:0];
    }
    
    for (NSInteger i = 0; i<self.total; i++) {
        UIButton *btn = [self viewWithTag:1000+i];
        if (btn && i != 0 && i != _currentIndex) {
            btn.layer.borderColor = ColorRGB(177, 177, 177).CGColor;
        }else if (btn && i != 0 && i == _currentIndex){
            [btn setTitle:str forState:0];
            btn.layer.borderColor = ColorRGB(100, 100, 100).CGColor;
        }else if (i == 0 && _currentIndex == 0){
            [btn setTitle:str forState:0];
        }
    }
    self.currentIndex += 1;
}

-(void)deleteKeyboardClick{
    //NewEnergy下点最后一个删除时，删除title 背景图 设置cartype为CarTypeTraditional
    if (_carType == CarTypeNewEnergy && _currentIndex == self.total-1) {
        UIButton *btn = [self viewWithTag:1000+_currentIndex];
        [btn setBackgroundImage:LocalImage(@"newEnergy_bg") forState:0];
        [btn setTitle:@"" forState:0];
        self.carType = CarTypeTraditional;
    }
    //NewEnergy点删除后走下面的for循环 不会执行  因为currentindex是NewEnergy最大值不会跟total的i重合
    // Traditional模式下 将当前的btn设置成title为空
    for (NSInteger i = 0; i<self.total; i++) {
        UIButton *btn = [self viewWithTag:1000+i];
        if (btn && i != 0 && i == _currentIndex){
            [btn setTitle:@"" forState:0];
        }
    }
    
    self.currentIndex -= 1;
    //删除完毕后  会将当前焦点前移-1，需要重新显示焦点
    for (NSInteger i = 0; i<self.total; i++) {
        UIButton *btn = [self viewWithTag:1000+i];
        if (btn && i != 0 && i != _currentIndex) {
            btn.layer.borderColor = ColorRGB(177, 177, 177).CGColor;
        }else if (btn && i != 0 && i == _currentIndex){
            btn.layer.borderColor = ColorRGB(100, 100, 100).CGColor;
        }
    }
}

- (NSInteger)total{
    if (_carType == CarTypeTraditional) {
        return 7;
    }
    return 8;
}

- (void)setCurrentType:(CarNumberInputCurrentType)currentType{
    _currentType = currentType;
    if (_currentType == CarNumberInputCurrentTypeProvince) {
        [self showProvinceView];
        [self dismissNumberLetterView];
        [self dismissOnlyLetterView];
    }else if (_currentType == CarNumberInputCurrentTypeCity){
        [self showOnlyLetterView];
        [self dismissProvinceView];
        [self dismissNumberLetterView];
    }else if (_currentType == CarNumberInputCurrentTypeOther){
        [self showNumberLetterView];
        [self dismissProvinceView];
        [self dismissOnlyLetterView];
    }
}

#pragma mark 3个子视图和本视图的显示隐藏动画
-(void)showInputView{
    self.hidden = NO;
    [_bgView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset((screenHeight-H(173))/2);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.currentType = CarNumberInputCurrentTypeProvince;
    }];
}

-(void)dismissInputView{
    [_bgView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(screenHeight);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

-(void)showProvinceView{
    [self dismissOnlyLetterView];
    [self dismissNumberLetterView];
    self.provinceView.hidden = NO;
    [self.provinceView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(screenHeight-H(300));
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)dismissProvinceView{
    [self.provinceView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(screenHeight);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.provinceView.hidden = YES;
    }];
}

-(void)showOnlyLetterView{
    [self dismissProvinceView];
    [self dismissNumberLetterView];
    self.onlyLetterView.hidden = NO;
    [self.onlyLetterView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(screenHeight-H(220));
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)dismissOnlyLetterView{
    [self.onlyLetterView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(screenHeight);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.onlyLetterView.hidden = YES;
    }];
}

-(void)showNumberLetterView{
    [self dismissProvinceView];
    [self dismissOnlyLetterView];
    self.numberLetterView.hidden = NO;
    [self.numberLetterView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(screenHeight-H(275));
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)dismissNumberLetterView{
    [self.numberLetterView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(screenHeight);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.numberLetterView.hidden = YES;
    }];
}

@end
