//
//  EmitterLayer.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/5.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "EmitterLayer.h"

@interface EmitterLayer ()

@property (nonatomic, strong) UIButton *button;

@property (strong, nonatomic) CAEmitterLayer *explosionLayer;

@end

@implementation EmitterLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 20, 20);
    [self.button setImage:[UIImage imageNamed:@"support@2x"] forState:UIControlStateNormal];
    self.button.center = self.view.center;
    [self.view addSubview:self.button];
    
    
    
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name           = @"explosion";
    explosionCell.alphaRange     = 0.10;
    explosionCell.alphaSpeed     = -1.0;
    explosionCell.lifetime       = 0.7;
    explosionCell.lifetimeRange  = 0.3;
    explosionCell.birthRate      = 0;
    explosionCell.velocity       = 40.00;
    explosionCell.velocityRange  = 10.00;
    explosionCell.scale          = 0.03;
    explosionCell.scaleRange     = 0.02;
    explosionCell.contents       = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
    
    self.explosionLayer               = [CAEmitterLayer layer];
    self.explosionLayer.name          = @"emitterLayer";
    self.explosionLayer.emitterShape  = kCAEmitterLayerCircle;
    self.explosionLayer.emitterMode   = kCAEmitterLayerOutline;
    self.explosionLayer.emitterSize   = CGSizeMake(10, 0);
    self.explosionLayer.emitterCells  = @[explosionCell];
    self.explosionLayer.renderMode    = kCAEmitterLayerOldestFirst;
    self.explosionLayer.masksToBounds = NO;
    self.explosionLayer.position      = CGPointMake(10, 10);
    self.explosionLayer.zPosition     = -1;
    [self.button.layer addSublayer:self.explosionLayer];
    
    [self.button addTarget:self action:@selector(startC) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startC {
    //进入下一个动作
//    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
    
//    //explosionLayer开始时间
    self.explosionLayer.beginTime = CACurrentMediaTime();
    //explosionLayer每秒喷射的2500个
    //CAEmitterLayer 根据自己的 emitterCells 属性找到名叫 explosion 的 cell，
    //并设置它的 birthRate 为 500。从而间接地控制了动画的开始。
    [self.explosionLayer setValue:@2500 forKeyPath:@"emitterCells.explosion.birthRate"];
    //停止喷射
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}


/**
 *  大量喷射
 */
- (void)explode {
    //explosionLayer开始时间
    self.explosionLayer.beginTime = CACurrentMediaTime();
    //explosionLayer每秒喷射的2500个
    [self.explosionLayer setValue:@2500 forKeyPath:@"emitterCells.explosion.birthRate"];
    //停止喷射
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

/**
 *  停止喷射
 */
- (void)stop {
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}

@end
