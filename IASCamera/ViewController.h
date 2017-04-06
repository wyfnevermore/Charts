//
//  ViewController.h
//  IASCamera
//
//  Created by wyfnevermore on 2017/4/1.
//  Copyright © 2017年 wyfnevermore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic,assign)NSInteger discount;
@property (strong,nonatomic)UIScrollView *imgPickerScollView;
@property (strong,nonatomic)NSString* str;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *connect;

- (IBAction)startBtn:(id)sender;
- (IBAction)connect:(id)sender;

- (void)reloadimgDelegate;

@end

