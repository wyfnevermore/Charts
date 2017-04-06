//
//  TypePickerItem.m
//  IASCamera
//
//  Created by wyfnevermore on 2017/4/1.
//  Copyright © 2017年 wyfnevermore. All rights reserved.
//

#import "TypePickerItem.h"

@implementation TypePickerItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTapGesture];
    }
    return self;
}

- (void)addTapGesture
{
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}

- (void)tap
{
    if (self.PickerItemSelectBlock) {
        self.PickerItemSelectBlock(self.index);
    }
}

// 留给子类调用
- (void)changeSizeOfItem{}
- (void)backSizeOfItem{}


@end
