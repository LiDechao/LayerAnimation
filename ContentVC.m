//
//  ContentVC.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/5.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "ContentVC.h"

@interface ContentVC ()

@end

@implementation ContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.frame = CGRectMake(100, 100, 200, 400);
    [self.view.layer addSublayer:layer];
    
    UIImage *image = [UIImage imageNamed:@"shark.png"];
    layer.contents = (id)image.CGImage; // 貌似只要强转id就能显示，(__bridge id)image.CGImage，但是必须得是CGImage;
    
    layer.contentsGravity = kCAGravityResizeAspect; // 调整自适应，同view的contentMode
    
}

@end
