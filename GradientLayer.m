//
//  GradientLayer.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/12.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "GradientLayer.h"

@interface GradientLayer ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *contentView2;

@end

@implementation GradientLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /* 
     * 简单的两种颜色的对角线渐变
     *
     */
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.contentView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.contentView.bounds;
    [self.contentView.layer addSublayer:gradientLayer];
    
    // set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    
    // 单位坐标系进行的定义，所以左上角坐标是{0, 0}，右下角坐标是{1, 1}
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    
    /*
     * 多重渐变
     *
     */
    
    self.contentView2 = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [self.view addSubview:self.contentView2];
    
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = self.contentView2.bounds;
    [self.contentView2.layer addSublayer:gradientLayer2];
    
    // set gradient colors
    gradientLayer2.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor];
    
    // set locations
    gradientLayer2.locations = @[@0.0, @0.25, @0.5];
    
    //set gradient start and end points
    gradientLayer2.startPoint = CGPointMake(0, 0);
    gradientLayer2.endPoint = CGPointMake(1, 1);
    
}

@end
