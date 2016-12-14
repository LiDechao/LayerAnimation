//
//  ReplicatorLayer.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/13.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "ReplicatorLayer.h"

#define SYS_DEVICE_WIDTH    ([[UIScreen mainScreen] bounds].size.width)   // 屏幕宽度
#define SYS_DEVICE_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)  // 屏幕长度

@interface ReplicatorLayer ()

@end

@implementation ReplicatorLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 音乐的条形图
    [self initMusicReplicatorLayer];
    
    // 心形图
    [self initHeartReplicatorLayer];

}

// 心形图
- (void)initHeartReplicatorLayer {
    // love路径
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0, 200)];
    [tPath addQuadCurveToPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0, 400) controlPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0 + 200, 20)];
    [tPath addQuadCurveToPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0, 200) controlPoint:CGPointMake(SYS_DEVICE_WIDTH/2.0 - 200, 20)];
    [tPath closePath];
    
    // 具体的layer
    UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    tView.center = CGPointMake(SYS_DEVICE_WIDTH/2.0, 200);
    tView.layer.cornerRadius = 5;
    tView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    // 动作效果
    CAKeyframeAnimation *loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    loveAnimation.path = tPath.CGPath;
    loveAnimation.duration = 8;
    loveAnimation.repeatCount = MAXFLOAT;
    
    [tView.layer addAnimation:loveAnimation forKey:@"loveAnimation"];
    
    CAReplicatorLayer *_loveLayer = [CAReplicatorLayer layer];
    _loveLayer.instanceCount = 40;                // 40个layer
    _loveLayer.instanceDelay = 0.2;               // 每隔0.2出现一个layer
    _loveLayer.instanceColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    _loveLayer.instanceGreenOffset = -0.03;       // 颜色值递减。
    _loveLayer.instanceRedOffset = -0.02;         // 颜色值递减。
    _loveLayer.instanceBlueOffset = -0.01;        // 颜色值递减。
    [_loveLayer addSublayer:tView.layer];
    [self.view.layer addSublayer:_loveLayer];
}

// 音乐的条形图
- (void)initMusicReplicatorLayer {
    
    CAReplicatorLayer *_musicLayer = [CAReplicatorLayer layer];
    _musicLayer.frame = CGRectMake(SYS_DEVICE_WIDTH/2.0-50, 410, 100, 100);
    _musicLayer.backgroundColor = [UIColor greenColor].CGColor;
    _musicLayer.masksToBounds = YES;
    [self.view.layer addSublayer:_musicLayer];
    
    // 创建一个子layer，并以此来作为复制的基础
    CALayer *tLayer = [CALayer layer];
    tLayer.backgroundColor = [UIColor redColor].CGColor;
    [_musicLayer addSublayer:tLayer];
    
    // 给个参考的图层
#if 0
    CALayer *ttLayer = [CALayer layer];
    ttLayer.backgroundColor = [UIColor blueColor].CGColor;
    [_musicLayer addSublayer:ttLayer];
    ttLayer.frame = CGRectMake(20, 70, 10, 40);
#endif
    
    // 给该子layer加动画
    CABasicAnimation *musicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    musicAnimation.duration = 0.35;
    musicAnimation.autoreverses = YES;
    musicAnimation.repeatCount = MAXFLOAT;
    
    // 通过改变位置关系来展现不同的动画效果
#if 0
    tLayer.frame = CGRectMake(10, 70, 10, 30);
    musicAnimation.fromValue = @(70);
    musicAnimation.toValue = @(45);
#else
    tLayer.frame = CGRectMake(10, 100, 10, 30);
    musicAnimation.fromValue = @(100);
    musicAnimation.toValue = @(85);
#endif
    
    [tLayer addAnimation:musicAnimation forKey:@"musicAnimation"];
    
    // 复制layer，会连layer的动画一同复制
    _musicLayer.instanceCount = 3;  // 复制的个数
    _musicLayer.instanceTransform = CATransform3DMakeTranslation(30, 0, 0);     //每个layer的间距。
    _musicLayer.instanceDelay = 0.2;    // 动画的延迟时间
    
}

@end
