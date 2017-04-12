//
//  ViewController.m
//  IASCamera
//
//  Created by wyfnevermore on 2017/4/1.
//  Copyright © 2017年 wyfnevermore. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kItemW SCREEN_WIDTH/12
#define kItemH SCREEN_HEIGHT*68/736


#import "ViewController.h"
#import "TypePickerScrollView.h"
#import "TypeMainItem.h"
#import "TypeMainModel.h"

@interface ViewController ()<TypePickerScrollViewDataSource,TypePickerScrollViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    TypePickerScrollView *_pickerScollView;
    TypePickerScrollView *_mainPickerScollView;
    NSMutableArray *data;
    NSMutableArray *mainData;
    NSMutableArray *imgData;
    float bigX;
    float littleX;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    //按钮
    
    _startBtn.frame = CGRectMake(SCREEN_WIDTH*172/414, SCREEN_HEIGHT*646/736, SCREEN_HEIGHT*70/736, SCREEN_HEIGHT*70/736);
    _connect.frame = CGRectMake(SCREEN_WIDTH*52/414, SCREEN_HEIGHT*660/736, SCREEN_HEIGHT*40/736, SCREEN_HEIGHT*40/736);
    _setting.frame = CGRectMake(SCREEN_WIDTH*330/414, SCREEN_HEIGHT*667/736, SCREEN_HEIGHT*30/736, SCREEN_HEIGHT*30/736);
    
    // Do any additional setup after loading the view, typically from a nib.

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - UI
- (void)setUpUI
{

    // 1.数据源(大)
    mainData = [NSMutableArray array];
    NSArray *mainTitleArray = @[@"食品",@"母婴",@"体脂",@"保健品",@"大类五",@"大类六",@"大类七"];
    for (int i = 0; i < mainTitleArray.count; i++) {
        TypeMainModel *mainModel = [[TypeMainModel alloc] init];
        mainModel.dicountTitle = [mainTitleArray objectAtIndex:i];
        NSLog(@"%@",mainModel.dicountTitle);
        [mainData addObject:mainModel];
    }
    
    //数据源(小)
    data = [NSMutableArray array];
    NSArray *titleArray = @[@"大豆",@"奶粉",@"苹果",@"果冻",@"巧克力",@"珍珠粉",@"奶嘴",@"保鲜膜"];
    for (int i = 0; i < titleArray.count; i++) {
        TypeMainModel *model = [[TypeMainModel alloc] init];
        model.dicountTitle = [titleArray objectAtIndex:i];
        [data addObject:model];
    }

    //数据源(img)
    imgData = [NSMutableArray array];
    NSArray *imgTitleArray = @[@"药",@"奶",@"木",@"乳",@"爬",@"珍",@"88",@"鲜"];
    for (int i = 0; i < imgTitleArray.count; i++) {
        TypeMainModel *imgModel = [[TypeMainModel alloc] init];
        imgModel.dicountTitle = [imgTitleArray objectAtIndex:i];
        [imgData addObject:imgModel];
    }
    
    // 2.初始化(大)
    _mainPickerScollView = [[TypePickerScrollView alloc] initWithFrame:CGRectMake(kItemW, SCREEN_HEIGHT*15/736, SCREEN_WIDTH - kItemW*2, kItemH)];
    _mainPickerScollView.backgroundColor = [UIColor clearColor];
    _mainPickerScollView.itemWidth = _mainPickerScollView.frame.size.width / 5;
    _mainPickerScollView.itemHeight = kItemH;
    _mainPickerScollView.firstItemX = (_mainPickerScollView.frame.size.width - _mainPickerScollView.itemWidth) * 0.5;
    _mainPickerScollView.dataSource = self;
    _mainPickerScollView.delegate = self;
    [self.view addSubview:_mainPickerScollView];
    
    //初始化(小)
    _pickerScollView = [[TypePickerScrollView alloc] initWithFrame:CGRectMake(kItemW, SCREEN_HEIGHT*583/736, SCREEN_WIDTH - kItemW*2, kItemH)];
    _pickerScollView.backgroundColor = [UIColor clearColor];
    _pickerScollView.itemWidth = _pickerScollView.frame.size.width / 5;
    _pickerScollView.itemHeight = kItemH;
    _pickerScollView.firstItemX = (_pickerScollView.frame.size.width - _pickerScollView.itemWidth) * 0.5;
    _pickerScollView.dataSource = self;
    _pickerScollView.delegate = self;
    [self.view addSubview:_pickerScollView];
    
    
    //初始化(img)
    _imgPickerScollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*68/736, SCREEN_WIDTH, SCREEN_HEIGHT*529/736)];
    _imgPickerScollView.backgroundColor = [UIColor yellowColor];
    _imgPickerScollView.delegate = self;
    _imgPickerScollView.pagingEnabled = YES;
    [self.view addSubview:_imgPickerScollView];
    for (NSInteger i= 0; i<8; i++) {
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*(SCREEN_WIDTH), 0, SCREEN_WIDTH, SCREEN_HEIGHT*529/736)];
        view.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        [_imgPickerScollView addSubview:view];

    }
    _imgPickerScollView.contentSize = CGSizeMake(SCREEN_WIDTH * 8,0);
    _imgPickerScollView.clipsToBounds = NO;
    //[self.view sendSubviewToBack:_imgPickerScollView];
    
     
    // 3.刷新数据
    [_mainPickerScollView reloadData];
    [_pickerScollView reloadData];
    bigX = _imgPickerScollView.bounds.size.width/(_pickerScollView.frame.size.width / 5);
    littleX = (_pickerScollView.frame.size.width / 5)/_imgPickerScollView.bounds.size.width;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ///*
    if (scrollView == _imgPickerScollView) {
        _pickerScollView.scrollView.delegate = nil;
        _pickerScollView.scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x * littleX,0);
        [_pickerScollView reloadDelegate];
    }
    else
    {
        _imgPickerScollView.delegate = nil;
        _imgPickerScollView.contentOffset = CGPointMake(scrollView.contentOffset.x * bigX,0);
        _imgPickerScollView.delegate = self;
    }
    //*/
    /*
    _pickerScollView.scrollView.delegate = nil;
    _pickerScollView.scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x * littleX,0);
    _pickerScollView.scrollView.delegate = self;
    */
}

- (void)reloadimgDelegate{
    _imgPickerScollView.delegate = nil;
    _imgPickerScollView.contentOffset = CGPointMake(_pickerScollView.scrollView.contentOffset.x * bigX,0);
    _imgPickerScollView.delegate = self;
}

#pragma mark - dataSource
- (NSInteger)numberOfItemAtPickerScrollView:(TypePickerScrollView *)pickerScrollView
{
    if (pickerScrollView == _mainPickerScollView) {
        return mainData.count;
    }else{
        return data.count;
    }
}

- (TypePickerItem *)pickerScrollView:(TypePickerScrollView *)pickerScrollView itemAtIndex:(NSInteger)index
{
    // creat
    TypeMainItem *item = [[TypeMainItem alloc] initWithFrame:CGRectMake(0, 0, pickerScrollView.itemWidth, pickerScrollView.itemHeight)];
    
    // assignment
    TypeMainModel *model;
    if (pickerScrollView == _pickerScollView) {
        model = [data objectAtIndex:index];
        // tap
        item.PickerItemSelectBlock = ^(NSInteger d){
            [_pickerScollView scollToSelectdIndex:d];
        };
    }else if(pickerScrollView == _mainPickerScollView){
        model = [mainData objectAtIndex:index];
        // tap
        item.PickerItemSelectBlock = ^(NSInteger d){
            [_mainPickerScollView scollToSelectdIndex:d];
        };
    }else{
        model = [imgData objectAtIndex:index];
        // tap
        item.PickerItemSelectBlock = ^(NSInteger d){
            [_pickerScollView scollToSelectdIndex:d];
        };
    }
    model.dicountIndex = index;
    item.title = model.dicountTitle;
    [item setGrayTitle];
    return item;
}

#pragma mark - delegate
- (void)itemForIndexChange:(TypePickerItem *)item
{
    [item changeSizeOfItem];
}

- (void)itemForIndexBack:(TypePickerItem *)item
{
    [item backSizeOfItem];
}
/////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)startBtn:(id)sender {
    NSLog(@"确定--选择折扣Index为--%ld--%ld",(long)_pickerScollView.seletedIndex,(long)_mainPickerScollView.seletedIndex);
    
    NSString *title;
    for (int i = 0; i < data.count; i++) {
        TypeMainModel *model = [data objectAtIndex:i];
        if (model.dicountIndex == _pickerScollView.seletedIndex) {
            title = model.dicountTitle;
        }
    }
    
    //通知框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)connect:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"未集成蓝牙" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)setting:(id)sender {
}
@end
