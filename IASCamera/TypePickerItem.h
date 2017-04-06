//
//  TypePickerItem.h
//  IASCamera
//
//  Created by wyfnevermore on 2017/4/1.
//  Copyright © 2017年 wyfnevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypePickerItem : UIView

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, assign)CGSize originalSize;
@property (nonatomic, assign)BOOL selected;
/**
 *  选中回调
 */
@property (nonatomic, copy) void(^PickerItemSelectBlock)(NSInteger index);

/**
 *  子类重写实现
 */
- (void)changeSizeOfItem;
- (void)backSizeOfItem;

@end
