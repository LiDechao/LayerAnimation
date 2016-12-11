//
//  EmitterLayer_Snow.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/11.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "EmitterLayer_Snow.h"

@interface EmitterLayer_Snow ()

@end

@implementation EmitterLayer_Snow

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = item;
    
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //发射点的位置
    snowEmitter.emitterPosition = CGPointMake(CGRectGetWidth(self.view.frame) / 2, -30);
    snowEmitter.emitterSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 2, 0.0f);
    snowEmitter.emitterShape = kCAEmitterLayerLine; // 发射源的形状
    snowEmitter.emitterMode = kCAEmitterLayerOutline;
    
    snowEmitter.shadowColor = [UIColor whiteColor].CGColor;
    snowEmitter.shadowOffset = CGSizeMake(0.0f, 1.0f);
    snowEmitter.shadowRadius = 0.0f;
    snowEmitter.shadowOpacity = 1.0f;
    
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    
    snowCell.birthRate = 1.0f; //每秒出现多少个粒子
    snowCell.lifetime = 120.0f; // 粒子的存活时间
    snowCell.velocity = -10; //速度
    snowCell.velocityRange = 10; // 平均速度
    snowCell.yAcceleration = 2;//粒子在y方向上的加速度
    snowCell.emissionRange = 0.5f * M_PI; //发射的弧度
    snowCell.spinRange = 0.75f * M_PI; // 粒子的平均旋转速度
    snowCell.contents = (id)[UIImage imageNamed:@"snow"].CGImage;
    snowCell.color = [UIColor colorWithRed:0.6 green:0.658 blue:0.743 alpha:1.0].CGColor;
    
    snowEmitter.emitterCells = @[snowCell];
    
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
}

- (void)back {
    for (CALayer *subLayer in self.view.layer.sublayers) {
        if ([subLayer isKindOfClass:[CAEmitterLayer class]]) {
            CAEmitterLayer *la = (CAEmitterLayer *)subLayer;
            [la removeFromSuperlayer];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
