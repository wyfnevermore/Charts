//
//  TypeMainItem.m
//  IASCamera
//
//  Created by wyfnevermore on 2017/4/5.
//  Copyright © 2017年 wyfnevermore. All rights reserved.
//

#define kITEM_WH 80
#define MLColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kRGB220 MLColor(220, 220, 220, 1.0)
#define kRGB236 MLColor(254, 208, 55, 1.0)

#import "TypeMainItem.h"

@implementation TypeMainItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    _discount = [UIButton buttonWithType:UIButtonTypeCustom];
    _discount.enabled = NO;
    _discount.titleLabel.font = [UIFont systemFontOfSize:14];
    CGFloat itemW = kITEM_WH;
    CGFloat itemH = kITEM_WH;
    CGFloat itemX = (self.frame.size.width - itemW)*0.5;
    CGFloat itemY = (self.frame.size.height - itemH) *0.5;
    _discount.frame = CGRectMake(itemX, itemY, itemW, itemH);
    [self addSubview:_discount];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_discount setTitle:title forState:UIControlStateNormal];
}

- (void)setRedTitle
{
    [_discount setTitleColor:kRGB236 forState:UIControlStateNormal];
    _discount.titleLabel.font = [UIFont systemFontOfSize:18];
}

- (void)setGrayTitle
{
    [_discount setTitleColor:kRGB220 forState:UIControlStateNormal];
    _discount.titleLabel.font = [UIFont systemFontOfSize:14];
}

/**
 *  改变item成红色. frame变大
 */
- (void)changeSizeOfItem
{
    [self setRedTitle];
    CGFloat itemW = kITEM_WH + kITEM_WH*0.3;
    CGFloat itemH = kITEM_WH + kITEM_WH*0.3;
    CGFloat itemX = (self.frame.size.width - itemW)*0.5;
    CGFloat itemY = (self.frame.size.height - itemH) *0.5;
    _discount.frame = CGRectMake(itemX, itemY, itemW, itemH);
}

/**
 *  改变item成灰色，frame变小
 */
- (void)backSizeOfItem
{
    [self setGrayTitle];
    CGFloat itemW = kITEM_WH;
    CGFloat itemH = kITEM_WH;
    CGFloat itemX = (self.frame.size.width - itemW)*0.5;
    CGFloat itemY = (self.frame.size.height - itemH) *0.5;
    _discount.frame = CGRectMake(itemX, itemY, itemW, itemH);
}

@end
