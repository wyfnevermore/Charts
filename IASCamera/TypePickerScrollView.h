//
//  TypePickerScrollView.h
//  IASCamera
//
//  Created by wyfnevermore on 2017/4/1.
//  Copyright © 2017年 wyfnevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TypePickerItem,TypePickerScrollView;

@protocol TypePickerScrollViewDelegate <NSObject>

/**
 
 *  选中（代理方法-可选）
 *
 *  @param menuScollView TypePickerScrollView
 *  @param index         下标
 */
@optional
- (void)pickerScrollView:(TypePickerScrollView *)menuScrollView
   didSelecteItemAtIndex:(NSInteger)index;

/**
 *  改变中心位置的Item样式
 *
 *  @param item TypePickerItem
 */
- (void)itemForIndexChange:(TypePickerItem *)item;

/**
 *  改变-非-中心位置的Item样式
 *
 *  @param item TypePickerItem
 */
- (void)itemForIndexBack:(TypePickerItem *)item;

@end

@protocol TypePickerScrollViewDataSource <NSObject>

/**
 *  个数
 *
 *  @param pickerScrollView TypePickerScrollView
 *
 *  @return 需要展示的item个数
 */
- (NSInteger)numberOfItemAtPickerScrollView:(TypePickerScrollView *)pickerScrollView;

/**
 *  用来创建TypePickerItem
 *
 *  @param pickerScrollView TypePickerScrollView
 *  @param index         位置下标
 *
 *  @return TypePickerItem
 */
- (TypePickerItem *)pickerScrollView:(TypePickerScrollView *)pickerScrollView
                       itemAtIndex:(NSInteger)index;

@end

@interface TypePickerScrollView : UIView

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *items;

/** 选中下标 */
@property (nonatomic, assign)NSInteger seletedIndex;
/** menu宽 */
@property (nonatomic, assign)CGFloat itemWidth;
/** menu高 */
@property (nonatomic, assign)CGFloat itemHeight;
/** 第一个item X值 */
@property (nonatomic, assign)CGFloat firstItemX;

@property (nonatomic, weak)id<TypePickerScrollViewDelegate> delegate;
@property (nonatomic, weak)id<TypePickerScrollViewDataSource> dataSource;

- (void)reloadData;
- (void)reloadDelegate;
- (void)scollToSelectdIndex:(NSInteger)index;

@end
