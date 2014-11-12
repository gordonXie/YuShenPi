//
//  ServiceListItemCell.m
//  YuShenPi
//
//  Created by xieguocheng on 14-11-12.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "ServiceListItemCell.h"

@implementation ServiceListItemCell
@synthesize cellTitle,windowType,ownerVC;
- (void)layoutSubviews{
    [super layoutSubviews];
    float startH = 0;
    const float leftEdge = 10.0;
    const float titleHeight = 30.0;
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(leftEdge, startH, self.frame.size.width, titleHeight)];
    titleLbl.text = cellTitle;
    [self addSubview:titleLbl];
    
    startH += titleHeight+5;
    
    const float windowImgSizeW = 65.0;
    const float windowImgSizeH = 65.0*220.0/178.0;
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(leftEdge, startH, windowImgSizeW, windowImgSizeH)];
    [self addSubview:imgView];
    
    const float windowLblH = 20.0;
    UILabel *windowLbl = [[UILabel alloc]initWithFrame:CGRectMake(leftEdge, startH+windowImgSizeH, windowImgSizeW, windowLblH)];
//    [self addSubview:windowLbl];
    
    UILabel *hintLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(leftEdge*2+windowImgSizeW, startH-5, 200, titleHeight)];
    hintLbl1.text = @"不收费，文件上传";
    [self addSubview:hintLbl1];
    
    UILabel *hintLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(leftEdge*2+windowImgSizeW, startH+windowImgSizeH/2.0, 200, titleHeight)];
    [self addSubview:hintLbl2];
    
    switch (windowType) {
        case KCellWindowType_Gongshang:
        {
            [imgView setImage:[UIImage imageNamed:@"sgongshang@2x"]];
            windowLbl.text = @"工商局";
            hintLbl2.text = @"办理窗口：工商窗口";
        }
            break;
        case KCellWindowType_Zhijian:
        {
            [imgView setImage:[UIImage imageNamed:@"szhijian@2x"]];
            windowLbl.text = @"质监局";
            hintLbl2.text = @"办理窗口：质监窗口";
        }
            break;
        case KCellWindowType_Guoshui:
        {
            [imgView setImage:[UIImage imageNamed:@"sguoshui@2x"]];
            windowLbl.text = @"国税局";
            hintLbl2.text = @"办理窗口：国税窗口";
        }
            break;
        case KCellWindowType_Gongan:
        {
            [imgView setImage:[UIImage imageNamed:@"sgongan@2x"]];
            windowLbl.text = @"公安局";
            hintLbl2.text = @"办理窗口：公安窗口";
        }
            break;
            
        default:
            break;
    }
    
    startH += windowImgSizeH;
    
    const float btnWidth = 120.0;
    const float btnHeight = 40.0;
    UIButton *onLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [onLineBtn setFrame:CGRectMake(leftEdge*2, startH, btnWidth, btnHeight)];
    onLineBtn.backgroundColor = [UIColor orangeColor];
    [onLineBtn setTitle:@"在线办理" forState:UIControlStateNormal];
    [onLineBtn addTarget:ownerVC action:@selector(onLineBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:onLineBtn];
    
    UIButton *guideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [guideBtn setFrame:CGRectMake(leftEdge*4+btnWidth, startH, btnWidth, btnHeight)];
    guideBtn.backgroundColor = [UIColor blueColor];
    [guideBtn setTitle:@"在线办理" forState:UIControlStateNormal];
    [guideBtn addTarget:ownerVC action:@selector(onGuideBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:guideBtn];
}


@end
