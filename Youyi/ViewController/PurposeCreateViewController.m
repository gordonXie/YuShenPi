//
//  PurposeCreateViewController.m
//  Youyi
//
//  Created by xieguocheng on 14-11-6.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "PurposeCreateViewController.h"
#import "UITextField+LabelAndImage.h"

#define KTableCellHeight 36.0
#define KTableCellLeftSpace 15.0

@interface PurposeCreateViewController ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView    *_baseScrollView;
    UITextField     *_nameTF;
    UITextField     *_actionTF;
    UITextView      *_descriptionTV;
//    UIDatePicker    *_startDate;
//    UIDatePicker    *_endDate;
    
    UITableView     *_tableView;
    
    //for PickerView
    UIPickerView    *_durationTime;
    UIPickerView    *_cycleTime;
    UIPickerView    *_startTime;
    UIPickerView    *_endTime;
    
    NSArray         *_durationArray;
    NSArray         *_cycleArray;
    
    UIView *_bgView;
    UIView *_pickerHeadView;
    UIPickerView *_pickerView;
    NSArray *_rangeArray;
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
    
    [self addTableView];
}

- (void)addTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            case 1:
            {
                return KTableCellHeight;
            }
                break;
            case 2:
            {
                return KTableCellHeight*2+[XCommon heightForString:_descriptionTV.text fontSize:17.0 andWidth:SCREEN_WIDTH];
            }
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            case 1:
            {
                return KTableCellHeight;
            }
                break;
            case 2:
            {
                return KTableCellHeight*2+[XCommon heightForString:_descriptionTV.text fontSize:17.0 andWidth:SCREEN_WIDTH];
            }
                
            default:
                break;
        }
    }
    
    return KTableCellHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section==0) {
            switch (indexPath.row) {
                case 0:
                {
                    if (_nameTF==nil) {
                        _nameTF = [[UITextField alloc]initWithFrame:CGRectMake(KTableCellLeftSpace, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight)];
                        [_nameTF setBackgroundColor:[UIColor clearColor]];
                        _nameTF.placeholder = @"9个字以内";
                        _nameTF.delegate = self;
                        [_nameTF setLeftLabelWithText:@"名称:  "];
                        [cell addSubview:_nameTF];
                    }
                }
                    break;
                case 1:
                {
                    if (_actionTF==nil) {
                        _actionTF = [[UITextField alloc]initWithFrame:CGRectMake(KTableCellLeftSpace, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight)];
                        [_actionTF setBackgroundColor:[UIColor clearColor]];
                        _actionTF.placeholder = @"显示个性";
                        _actionTF.delegate = self;
                        [_actionTF setLeftLabelWithText:@"action:  "];
                        [cell addSubview:_actionTF];
                    }
                }
                    break;
                case 2:
                {
                    if (_descriptionTV==nil) {
                        [cell addSubview:[self descriptionCellView]];
                    }
                }
                    break;
                default:
                    break;
            }
        }else if (indexPath.section==1){
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"持续时间";
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"周期";
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"时间段";
//                    cell.detailTextLabel.text = @"周五";  //不显示
                }
                    break;
                default:
                    break;
            }
        }
    }
    
    return cell;
}

-(UIView*)descriptionCellView
{
    
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(KTableCellLeftSpace, 0, SCREEN_WIDTH-KTableCellLeftSpace, KTableCellHeight*3)];
    UILabel *decLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, KTableCellHeight)];
    decLbl.font = [UIFont systemFontOfSize:15.0];
    decLbl.text = @"描述:";
    [baseView addSubview:decLbl];
    
    CGRect desRect = CGRectMake(0, KTableCellHeight, baseView.frame.size.width, KTableCellHeight);
    _descriptionTV = [[UITextView alloc]initWithFrame:desRect];
    [_descriptionTV setBackgroundColor:[UIColor clearColor]];
    _descriptionTV.delegate = self;
    _descriptionTV.font = [UIFont systemFontOfSize:KTableCellFontCommon];
    [baseView addSubview:_descriptionTV];
    
    return baseView;
}


- (void)addPickerView
{
    if (_pickerView==nil) {
        _rangeArray = [[NSArray alloc]initWithObjects:@"1",@"5",@"10",@"20",@"50", nil];
        
        _bgView = [[UIView alloc]initWithFrame:self.view.bounds];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.alpha = 0.3;
        [self.view addSubview:_bgView];
        
        float pickerHeight = 160.0;
        float headHeight = 40.0;
        _pickerHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-headHeight-pickerHeight, SCREEN_WIDTH, headHeight)];
        _pickerHeadView.backgroundColor = [XCommon hexStringToColor:@"#078065"];
        _pickerHeadView.alpha = 0.9;
        [self.view addSubview:_pickerHeadView];
        
        float btnWidth = 40.0;
        float btnHeight = 30.0;
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(SCREEN_WIDTH-30-btnWidth*2, (headHeight-btnHeight)/2.0, btnWidth, btnHeight);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(onCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_pickerHeadView addSubview:cancelBtn];
        
        UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        completeBtn.frame = CGRectMake(SCREEN_WIDTH-10-btnWidth, (headHeight-btnHeight)/2.0, btnWidth, btnHeight);
        [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        [completeBtn addTarget:self action:@selector(onCompleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_pickerHeadView addSubview:completeBtn];
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-pickerHeight, SCREEN_WIDTH, pickerHeight)];
        //        _pickerView.frame = CGRectOffset(_pickerView.frame, 0, 20);
        _pickerView.backgroundColor = [XCommon hexStringToColor:@"#078065"];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
        
        [self.view addSubview:_pickerView];
    }
    
    [self selectPickerView];
    _bgView.hidden = NO;
    _pickerHeadView.hidden = NO;
    _pickerView.hidden = NO;
}

- (void)selectPickerView
{
    NSString *rangeStr;
    if ([XCommon isNullString:[XCommon UserDefaultGetValueFromKey:SEARCHRANGE]]) {
        rangeStr = KDefaultSearchRange;
    }else
        rangeStr = [XCommon UserDefaultGetValueFromKey:SEARCHRANGE];
    for (int i=0;i<_rangeArray.count;i++) {
        if ([[_rangeArray objectAtIndex:i] isEqualToString:rangeStr]) {
            [_pickerView selectRow:i inComponent:0 animated:NO];
            break;
        }
    }
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

- (void)onCancelBtnClick
{
    _bgView.hidden = YES;
    _pickerHeadView.hidden = YES;
    _pickerView.hidden = YES;

    _durationTime.hidden = YES;
}
- (void)onCompleteBtnClick
{
    _bgView.hidden = YES;
    _pickerHeadView.hidden = YES;
    _pickerView.hidden = YES;
    
    int selIndex = [_pickerView selectedRowInComponent:0];
    
    NSString *rangeStr = [_rangeArray objectAtIndex:selIndex];
    
    [XCommon UserDefaultSetValue:rangeStr forKey:SEARCHRANGE];
    [_tableView reloadData];
}
@end
