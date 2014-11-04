//
//  GuideViewController.m
//  NewYiPai
//
//  Created by 李恒 on 13-5-6.
//  Copyright (c) 2013年 李恒. All rights reserved.
//
#import "GlobalConfig.h"
#import "GuideViewController.h"
//#import "HomePageViewController.h"
#import "MobClick.h"
//#import "RegisterViewController.h"

const int MAX_PAGE_NUM    =    3;

@interface GuideViewController ()

@end

@implementation GuideViewController

@synthesize scroll_view = mScroll_view;


-(void)DownButtonClick
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"1" forKey:GuideStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[UIApplication sharedApplication]setStatusBarHidden:FALSE];
//    [appDelegate.navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//    [self presentViewController:appDelegate.navController animated:YES completion:nil];
}

-(id) init
{
    self = [super init];
    if (self)
    {
        self.scroll_view = nil;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"引导(GuideViewController)"];
}

-(void)dealloc
{
    [mScroll_view release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([[[UIDevice currentDevice ]systemVersion] integerValue]>=7) {
        self.view.bounds = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height );
    }
    CGRect rect = self.view.bounds;
    
    UIImage *image0 = nil;
    UIImage *image1 = nil;
    UIImage *image2 = nil;
    UIImage *image3 = nil;
    if(SCREEN_HEIGHT > 480)
    {
        image0 = [UIImage imageNamed:@"导入页1_ios5@2x.png"];
        image1 = [UIImage imageNamed:@"导入页2_ios5@2x.png"];
        image2 = [UIImage imageNamed:@"导入页3_ios5@2x.png"];
    }
    else
    {
        image0 = [UIImage imageNamed:@"导入页1@2x.png"];
        image1 = [UIImage imageNamed:@"导入页2@2x.png"];
        image2 = [UIImage imageNamed:@"导入页3@2x.png"];
    }

    self.scroll_view = [[UIScrollView alloc] initWithFrame: rect];
	self.scroll_view.showsVerticalScrollIndicator = NO;
	self.scroll_view.showsHorizontalScrollIndicator = YES;
	self.scroll_view.pagingEnabled = YES;
	self.scroll_view.delegate = self;
    self.scroll_view.bounces = NO;
    self.scroll_view.showsHorizontalScrollIndicator = NO;
    int index = 0;
    for(int i = 0 ;i < MAX_PAGE_NUM; i ++)
    {
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:rect]autorelease];
        imageView.frame = CGRectMake(i * SCREEN_WIDTH, 0.0, SCREEN_WIDTH, self.scroll_view.frame.size.height);

        if(i == 0)
        {
            imageView.image = image0;
        }
        else if(i == 1)
        {
            imageView.image = image1;
        }
        else if(i == 2)
        {
            imageView.image = image2;
        }
        else if(i == 3)
        {
            imageView.image = image3;
        }
        imageView.backgroundColor = [UIColor clearColor];
        [self.scroll_view addSubview:imageView];
        index ++;
    }
   
    [self.view addSubview:self.scroll_view];
    
    CGSize size = CGSizeMake(SCREEN_WIDTH * MAX_PAGE_NUM, SCREEN_HEIGHT);
    [self.scroll_view setContentSize:size];
    
    
    UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downButton.frame = CGRectMake((SCREEN_WIDTH - 150)/2 + SCREEN_WIDTH * (MAX_PAGE_NUM -1), SCREEN_HEIGHT - 80, 150.0f, 40.0f);
    [downButton setBackgroundImage:[UIImage imageNamed:@"进入-默认@2x"] forState:UIControlStateNormal];
    [downButton setBackgroundImage:[UIImage imageNamed:@"进入-点击@2x"] forState:UIControlStateHighlighted];
    [downButton addTarget:self
                   action:@selector(DownButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll_view addSubview:downButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"引导(GuideViewController)"];
}

@end
