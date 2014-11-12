//
//  PicsManageScrollView.m
//  CustomAPP
//
//  Created by xieguocheng on 14-8-28.
//  Copyright (c) 2014年 xieguocheng. All rights reserved.
//

#import "PicsManageScrollView.h"
#import "UIImageView+WebCache.h"
#import "SMPageControl.h"
#import "UIButton+WebCache.h"
#import "UIImage+Size.h"

#define ITEM_WIDTH 320.0
const int KBaseTag = 220;
const int KTimeSpace = 5.0;

@interface PicsManageScrollView()
{
    UILabel *_titleLbl;
    SMPageControl *_pageControl;
    UIScrollView *_scrollView;
    
    NSTimer *_timer;
    NSUInteger _currentScrollPage;
}

@end

@implementation PicsManageScrollView
@synthesize dataArray = _dataArray;
@synthesize picDelegate = _picDelegate;
@synthesize picViewType = _picViewType;
@synthesize picDataType = _picDataType;
@synthesize isTimeShow  = _isTimeShow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _picViewType = PicScrollViewCustom;
        _picDataType = PicScrollData_HotNews;
        self.backgroundColor = [UIColor whiteColor];
        _isTimeShow = NO;
        _currentScrollPage = 0;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    uint size = _dataArray.count;
    float funWidth = self.frame.size.width;
    
    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    
    for (int i=0; i<size; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*funWidth, 0, funWidth, self.frame.size.height);
        btn.tag = KBaseTag + i;
        if (_picDataType==PicScrollData_Local) {
            [btn setImage:[UIImage imageNamed:[_dataArray objectAtIndex:i]] forState:UIControlStateNormal];
        }else if (_picDataType==PicScrollData_HotAd) {
            [btn setImageWithURL:[NSURL URLWithString:[[_dataArray objectAtIndex:i]objectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"正在加载-大图@2x"]];
        }else{
            [btn setImageWithURL:[NSURL URLWithString:[[_dataArray objectAtIndex:i]objectForKey:@"hotPic"]] placeholderImage:[UIImage imageNamed:@"正在加载-大图@2x"]];
        }
        [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
    }
    
    _scrollView.contentSize = CGSizeMake(size*funWidth, self.frame.size.height);
    
    switch (_picViewType) {
        case PicScrollViewCustom:
            [self customTypeDraw];
            break;
        case PicScrollViewMiddle:
            [self middleTypeDraw];
            break;
        default:
            break;
    }
    if (_dataArray.count>0) {
        if (_picDataType==PicScrollData_Local) {
            //无标题
        }else if (_picDataType==PicScrollData_HotAd) {
            _titleLbl.text = [[_dataArray objectAtIndex:0] objectForKey:@"title"];
        }else{
            _titleLbl.text = [[_dataArray objectAtIndex:0] objectForKey:@"title"];
        }
    }
    
    if (_isTimeShow&&size>1) {
        [self startTime];
    }
}

- (void)customTypeDraw
{
    if (_titleLbl==nil) {
        const float keepViewH = 30.0;
        UIImageView *textBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-keepViewH, self.frame.size.width, keepViewH)];
        [textBgView setImage:[UIImage imageNamed:@"red_home_text_bg@2x"]];
        [self addSubview:textBgView];
        
        const float pageControlW = 100.0;
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, textBgView.frame.size.width-pageControlW-10, keepViewH)];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.textColor = [UIColor whiteColor];
        [textBgView addSubview:_titleLbl];
        
        _pageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(textBgView.frame.size.width-pageControlW, 0, pageControlW, textBgView.frame.size.height)];
        [_pageControl setPageIndicatorImage:[UIImage imageNamed:@""]];
        [_pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@""]];
        [textBgView addSubview:_pageControl];
    }
    
    [_pageControl setNumberOfPages:_dataArray.count];
}

- (void)middleTypeDraw
{
    if (_titleLbl==nil) {
        const float keepViewH = 40.0;
        UIImageView *textBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-keepViewH, self.frame.size.width, keepViewH)];
        [textBgView setImage:[UIImage imageNamed:@"red_home_text_bg@2x"]];
        [self addSubview:textBgView];
        
//        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, textBgView.frame.size.width, keepViewH)];
//        _titleLbl.backgroundColor = [UIColor clearColor];
//        _titleLbl.textColor = [UIColor whiteColor];
//        [textBgView addSubview:_titleLbl];
        
        const float pageControlW = 200.0;
        const float pageControlH = 20.0;
        _pageControl = [[SMPageControl alloc]initWithFrame:CGRectMake((textBgView.frame.size.width-pageControlW)/2.0, self.frame.size.height-keepViewH, pageControlW, pageControlH)];
        [_pageControl setPageIndicatorImage:[UIImage imageNamed:@""]];
        [_pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@""]];
        [self addSubview:_pageControl];
    }
    
    [_pageControl setNumberOfPages:_dataArray.count];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float targetX = scrollView.contentOffset.x;
//    NSArray *imageItems = objc_getAssociatedObject(self, (const void *)SG_FOCUS_ITEM_ASS_KEY);
//    if (_dataArray.count>=3)
//    {
//        if (targetX > ITEM_WIDTH * ([_dataArray count] -1)) {
//            targetX = 0;
//            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
//        }
////        else if(targetX <= 0)
////        {
////            targetX = ITEM_WIDTH *([_dataArray count]-2);
////            [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
////        }
//    }
    
    _currentScrollPage = (_scrollView.contentOffset.x+ITEM_WIDTH/2.0) / ITEM_WIDTH;
    
    if (_titleLbl) {
         _titleLbl.text = [[_dataArray objectAtIndex:_currentScrollPage] objectForKey:@"title"];
    }
    [_pageControl setCurrentPage:_currentScrollPage];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    NSLog(@"offset is %f",scrollView.contentOffset.x);
    int page = scrollView.contentOffset.x/self.frame.size.width+1;
    
    if (_titleLbl) {
         _titleLbl.text = [[_dataArray objectAtIndex:page-1] objectForKey:@"title"];
    }
    [_pageControl setCurrentPage:page-1];
}

- (void)onBtnClick:(id)sender
{
    if (_picDelegate&&[_picDelegate respondsToSelector:@selector(onPicSelectByIndex:)]) {
        [_picDelegate onPicSelectByIndex:(((UIButton*)sender).tag-KBaseTag)];
    }
}

- (void)scrollByTimer
{
//    if (_timer==nil) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:KTimeSpace target:self selector:@selector(scrollByTimer) userInfo:nil repeats:YES];
//    }
//
//    NSUInteger size = [_dataArray count];
//    float funWidth = self.frame.size.width;
//    NSLog(@"currentPage is %d",_currentScrollPage);
//    _currentScrollPage++;
//    if (_currentScrollPage>=size) {
//        _currentScrollPage = 0;
//    }
//
////   [ _scrollView scrollRectToVisible:CGRectMake(_currentScrollPage*funWidth, 0, funWidth, self.frame.size.height) animated:YES];
//    [_scrollView setContentOffset:CGPointMake(_currentScrollPage*funWidth, 0) animated:YES];
//    _titleLbl.text = [[_dataArray objectAtIndex:_currentScrollPage] objectForKey:@"title"];
//    [_pageControl setCurrentPage:_currentScrollPage];
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollByTimer) object:nil];
    
    CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
    targetX = (int)(targetX/ITEM_WIDTH) * ITEM_WIDTH;
    [self moveToTargetPosition:targetX];
    
    if ([_dataArray count]>1 && _isTimeShow)
    {
        [self performSelector:@selector(scrollByTimer) withObject:nil afterDelay:KTimeSpace];
    }
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
    BOOL animated = YES;
    //    NSLog(@"moveToTargetPosition : %f" , targetX);
    [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:animated];
}

- (void)startTime
{
    [self performSelector:@selector(scrollByTimer) withObject:nil afterDelay:KTimeSpace];
}
@end
