//
//  ViewController.m
//  淘点点评分
//
//  Created by XWQ on 15/4/27.
//  Copyright (c) 2015年 _Name.im_. All rights reserved.
//

#import "ViewController.h"
#import "RatingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{

    RatingView *bar = [[RatingView alloc] initWithFrame:CGRectMake(10, 50, self.view.frame.size.width-10*2, 50)];
    [self.view addSubview:bar];
    bar.enable = YES;
    bar.center = self.view.center;

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
