//
//  ViewController.m
//  ZSRating
//
//  Created by Zhangsong on 16/5/16.
//  Copyright (c) 2016年 zhangsong. All rights reserved.
//

#import "ViewController.h"
#import "ZSRatingControl.h"

@interface ViewController ()<ZSRatingControlDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZSRatingControl *ratingCtrl = [[ZSRatingControl alloc] initWithLocation:CGPointMake(50, 100) andMaxRating:5];
    ratingCtrl.backgroundColor = [UIColor clearColor];
    //设置初始rating，必须设置
    ratingCtrl.rating = 0;
    ratingCtrl.delegate = self;
    [self.view addSubview:ratingCtrl];
    
    NSLog(@"张松修改了");
}

- (void)ratingControl:(ZSRatingControl *)ratingControl didSelectedRating:(NSInteger)selectedRating
{
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
