//
//  HomeViewController.m
//  Youyi
//
//  Created by xieguocheng on 14-11-5.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "HomeViewController.h"
#import "PicsManageScrollView.h"
#import "ServiceListViewController.h"

float KBLUEPICSCROLLVIEWH;
const float KTITLEBARHEIHGT  = 40.0;
const float KTITLEFONTSIZE   = 20.0;
const float KTABLEVIEWHEIGHT = 140.0;
const float KTABLECELLHEIGHT = 30.0;

@interface HomeViewController ()<PicScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView    *_baseScrollView;
    
    float _startH;
    PicsManageScrollView *_picScrollView;
    
    UITableView *_tableView;
    NSMutableArray  *_tableArray;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initViews
{
    [super initViews];
    [self setTitle:@"服务中心"];
    [self addLeftBtn:@"退出"];
    [self addRightBtn:@"导航"];
    
    [self addBaseScrollView];
}

- (void)addBaseScrollView
{
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT)];
    [self.view addSubview:_baseScrollView];
    
    [self addItems];
    
}
- (void)addItems
{
    [self addPicView];
    [self addTableView];
    [self addOffices];
}

- (void)addPicView
{
    _startH = 0;
    KBLUEPICSCROLLVIEWH= SCREEN_WIDTH*230.0/600.0;
    _picScrollView = [[PicsManageScrollView alloc]initWithFrame:CGRectMake(0, _startH, SCREEN_WIDTH, KBLUEPICSCROLLVIEWH)];
    _picScrollView.picDataType = PicScrollData_Local;
    _picScrollView.picDelegate = self;
    _picScrollView.picViewType = PicScrollViewMiddle;
    _picScrollView.dataArray = [[NSMutableArray alloc]initWithObjects:@"focus_1@2x.jpg",@"focus_2@2x.jpg",@"focus_3@2x.jpg",@"focus_4@2x.jpg",@"focus_5@2x.jpg", nil];
    [_baseScrollView addSubview:_picScrollView];
    
    _startH += KBLUEPICSCROLLVIEWH;
}

- (void)addTableView
{
    UIImageView *titleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _startH, SCREEN_WIDTH, KTITLEBARHEIHGT)];
    titleImgView.image = [UIImage imageNamed:@""];
    [_baseScrollView addSubview:titleImgView];
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:titleImgView.frame];
    titleLbl.text = @" 热门服务";
    titleLbl.backgroundColor = [UIColor blackColor];
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:KTITLEFONTSIZE];
    [_baseScrollView addSubview:titleLbl];
    
    _startH += KTITLEBARHEIHGT;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _startH, SCREEN_WIDTH, KTABLEVIEWHEIGHT)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_baseScrollView addSubview:_tableView];
    
    _startH += KTABLEVIEWHEIGHT;
}

- (void)addOffices
{
    UIImageView *titleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _startH, SCREEN_WIDTH, KTITLEBARHEIHGT)];
    titleImgView.image = [UIImage imageNamed:@""];
    [_baseScrollView addSubview:titleImgView];
    
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:titleImgView.frame];
    titleLbl.text = @" 服务窗口";
    titleLbl.backgroundColor = [UIColor blackColor];
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:KTITLEFONTSIZE];
    [_baseScrollView addSubview:titleLbl];
    
    _startH += KTITLEBARHEIHGT;
    
    const float btnSize = 65.0;
    const float btnEdgeW = (SCREEN_WIDTH-btnSize*4)/5.0;
    const float btnEdgeH = 10.0;
    
    _startH += btnEdgeH;
    float lblStartH = _startH+btnSize+2;
//    float lblWidth = 60.0;
    float lblHeight = 12.0;
    
    const float textFontSize = 14.0;
    UIColor *textColor = [UIColor darkGrayColor];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(btnEdgeW, _startH, btnSize, btnSize)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"gongshang@2x"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onGongShangClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:btn1];
    
    UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(btn1.frame.origin.x, lblStartH, btnSize, lblHeight)];
    lbl1.text = @"工商窗口";
    lbl1.backgroundColor = [UIColor clearColor];
    lbl1.font = [UIFont systemFontOfSize:textFontSize];
    lbl1.textColor = textColor;
    lbl1.textAlignment = NSTextAlignmentCenter;
    [_baseScrollView addSubview:lbl1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(btnEdgeW*2+btnSize, _startH, btnSize, btnSize)];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"zhijian@2x"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(onZhiJianClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:btn2];
    
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(btn2.frame.origin.x, lblStartH, btnSize, lblHeight)];
    lbl2.text = @"质监窗口";
    lbl2.backgroundColor = [UIColor clearColor];
    lbl2.font = [UIFont systemFontOfSize:textFontSize];
    lbl2.textColor = textColor;
    lbl2.textAlignment = NSTextAlignmentCenter;
    [_baseScrollView addSubview:lbl2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setFrame:CGRectMake(btnEdgeW*3+btnSize*2, _startH, btnSize, btnSize)];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"guoshui@2x"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(onGuoShuiClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:btn3];
    
    UILabel *lbl3 = [[UILabel alloc]initWithFrame:CGRectMake(btn3.frame.origin.x, lblStartH, btnSize, lblHeight)];
    lbl3.text = @"国税窗口";
    lbl3.backgroundColor = [UIColor clearColor];
    lbl3.font = [UIFont systemFontOfSize:textFontSize];
    lbl3.textColor = textColor;
    lbl3.textAlignment = NSTextAlignmentCenter;
    [_baseScrollView addSubview:lbl3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setFrame:CGRectMake(btnEdgeW*4+btnSize*3, _startH, btnSize, btnSize)];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"gongan@2x"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(onGongAnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:btn4];
    
    UILabel *lbl4 = [[UILabel alloc]initWithFrame:CGRectMake(btn4.frame.origin.x, lblStartH, btnSize, lblHeight)];
    lbl4.text = @"公安窗口";
    lbl4.backgroundColor = [UIColor clearColor];
    lbl4.font = [UIFont systemFontOfSize:textFontSize];
    lbl4.textColor = textColor;
    lbl4.textAlignment = NSTextAlignmentCenter;
    [_baseScrollView addSubview:lbl4];
    
    [_baseScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, lblStartH+lblHeight+10)];
}

- (void)onRightBtnClick:(id)sender
{
   
}

#pragma mark - PicSelectDelegate
- (void)onPicSelectByIndex:(int)index
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strIdentify = @"identify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentify];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strIdentify];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        const float edge = 5.0;
        const float imgW = 90.0;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(edge, edge, imgW, KTABLECELLHEIGHT-edge*2)];
        imgView.tag = 101;
        [cell.contentView addSubview:imgView];
        
        const float titleH = 20.0;
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(edge*2+imgW, edge, SCREEN_WIDTH-(edge*3+imgW), titleH)];
        titleLbl.tag = 102;
        [cell.contentView addSubview:titleLbl];
        
        const float contentH = 40.0;
        UILabel *conLbl = [[UILabel alloc]initWithFrame:CGRectMake(edge*2+imgW, edge+titleH, SCREEN_WIDTH-(edge*3+imgW), contentH)];
        conLbl.tag = 103;
        conLbl.font = [UIFont systemFontOfSize:14.0];
        conLbl.textColor = [UIColor darkGrayColor];
        conLbl.numberOfLines = 2;
        [cell.contentView addSubview:conLbl];
        
//        const float timeH = 12.0;
//        UILabel *timeLbl = [[UILabel alloc]initWithFrame:CGRectMake(edge*2+imgW, edge+titleH+contentH, self.frame.size.width-(edge*3+imgW), timeH)];
//        timeLbl.tag = 104;
//        timeLbl.textAlignment = NSTextAlignmentRight;
//        timeLbl.font = [UIFont systemFontOfSize:11.0];
//        timeLbl.textColor = [UIColor grayColor];
//        [cell.contentView addSubview:timeLbl];
    }
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:101];
    UILabel *titleLbl = (UILabel*)[cell.contentView viewWithTag:102];
    UILabel *conLbl = (UILabel*)[cell.contentView viewWithTag:103];
    UILabel *timeLbl = (UILabel*)[cell.contentView viewWithTag:104];
    
    NSDictionary *dic = [_tableArray objectAtIndex:indexPath.row];
    
//    [imgView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"thumbPic"]] placeholderImage:[UIImage imageNamed:@"正在加载-小图@2x"]];
//    titleLbl.text = [dic objectForKey:@"title"];
//    conLbl.text = [dic objectForKey:@"subContent"];
//    
//    timeLbl.text = [XCommon showDateOrTime:[dic objectForKey:@"time"]];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KTABLECELLHEIGHT;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

-(void)onGongShangClick:(id)sender
{
    ServiceListViewController *sListVC = [[ServiceListViewController alloc]init];
    sListVC.windowType = KCellWindowType_Gongshang;
    [appDelegate.navController pushViewController:sListVC animated:YES];
}
- (void)onZhiJianClick:(id)sender
{
    ServiceListViewController *sListVC = [[ServiceListViewController alloc]init];
    sListVC.windowType = KCellWindowType_Zhijian;
    [appDelegate.navController pushViewController:sListVC animated:YES];
}
- (void)onGuoShuiClick:(id)sender
{
    ServiceListViewController *sListVC = [[ServiceListViewController alloc]init];
    sListVC.windowType = KCellWindowType_Guoshui;
    [appDelegate.navController pushViewController:sListVC animated:YES];
}
- (void)onGongAnClick:(id)sender
{
    ServiceListViewController *sListVC = [[ServiceListViewController alloc]init];
    sListVC.windowType = KCellWindowType_Gongan;
    [appDelegate.navController pushViewController:sListVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
