//
//  TypeMainItem.h
//  IASCamera
//
//  Created by wyfnevermore on 2017/4/5.
//  Copyright © 2017年 wyfnevermore. All rights reserved.
//

#import "TypePickerItem.h"

@interface TypeMainItem : TypePickerItem

@property (nonatomic, strong)UIButton *discount;
@property (nonatomic, copy)NSString *title;

- (void)setRedTitle;
- (void)setGrayTitle;

@end
