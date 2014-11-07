//
//  PurposeCreateViewController.m
//  Youyi
//
//  Created by xieguocheng on 14-11-6.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "PurposeCreateViewController.h"
#import "UITextField+LabelAndImage.h"

@interface PurposeCreateViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIScrollView    *_baseScrollView;
    UITextField     *_nameTF;
    UITextField     *_actionTF;
    UITextView      *_descriptionTV;
//    UIDatePicker    *_startDate;
//    UIDatePicker    *_endDate;
    UIPickerView    *_durationTime;
    UIPickerView    *_cycleTime;
    UIPickerView    *_startTime;
    UIPickerView    *_endTime;
    
    NSArray         *_durationArray;
    NSArray         *_cycleArray;
}
@end

@implementation PurposeCreateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"新建意向"];
    [self addBackBtn];
    [self addRightBtn:@"保存"];
    
    [self addBaseScrollView];
}

- (void)addBaseScrollView
{
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_baseScrollView];
    
    [self addItems];
}

- (void)addItems
{
    float startH = 20.0;
    
    float TFWidth  = 300.0;
    float TFHeight = 30.0;
    
    float startW = (SCREEN_WIDTH-TFWidth)/2.0;
    
    float itemSpace = 10.0;
    
    CGRect nameRect = CGRectMake(startW, startH, TFWidth, TFHeight);
    _nameTF = [[UITextField alloc]initWithFrame:nameRect];
//    [_nameTF setBackground:[UIImage imageNamed:@"table_up@2x"]];
    [_nameTF setBackgroundColor:[UIColor clearColor]];
    _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTF.placeholder = @"9个字以内";
    _nameTF.delegate = self;
    [_nameTF setLeftLabelWithText:@"  名称:  "];
    [_baseScrollView addSubview:_nameTF];
    
    CGRect actionRect = CGRectMake(startW, startH+TFHeight+itemSpace, 150, TFHeight);
    _actionTF = [[UITextField alloc]initWithFrame:actionRect];
    //    [_nameTF setBackground:[UIImage imageNamed:@"table_up@2x"]];
    [_actionTF setBackgroundColor:[UIColor clearColor]];
    _actionTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _actionTF.placeholder = @"显示个性";
    _actionTF.delegate = self;
    [_actionTF setLeftLabelWithText:@"  action:  "];
    [_baseScrollView addSubview:_actionTF];
    
    UILabel *decLbl = [[UILabel alloc]initWithFrame:CGRectMake(startW, startH+TFHeight*2+itemSpace*2, 40, TFHeight)];
    decLbl.text = @"描述:";
    [_baseScrollView addSubview:decLbl];
    startH = startH+TFHeight*3+itemSpace*2;
    
    float TVHeight = 60.0;
    CGRect desRect = CGRectMake(startW, startH, TFWidth, TVHeight);
    _descriptionTV = [[UITextView alloc]initWithFrame:desRect];
    [_descriptionTV setBackgroundColor:[UIColor clearColor]];
    _descriptionTV.delegate = self;
    [_baseScrollView addSubview:_descriptionTV];
    startH += TVHeight+itemSpace;
    
    CGRect durationRect = CGRectMake(startW, startH, 40, TFHeight);
    UILabel *durationLbl = [[UILabel alloc]initWithFrame:durationRect];
    durationLbl.text = @"周期:";
    [_baseScrollView addSubview:durationLbl];
    
    _durationArray = [[NSArray alloc]initWithObjects:@"2周",@"3周",@"1月",@"2月",@"3月",@"6月", nil];
    _durationTime = [[UIPickerView alloc]initWithFrame:CGRectMake(startW+durationRect.size.width, startH, 100, TFHeight)];
    _durationTime.dataSource = self;
    _durationTime.delegate = self;
    [_baseScrollView addSubview:_durationTime];
    
    
}

#pragma mark - PickerViewDataSource
//以下3个方法实现PickerView的数据初始化
//确定picker的轮子个数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView==_startTime||pickerView==_endTime) {
        return 2;
    }
    return 1;
}
//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_durationArray count];
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_durationArray objectAtIndex:row];
}

@end
