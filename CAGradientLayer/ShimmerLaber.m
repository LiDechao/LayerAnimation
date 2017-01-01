//
//  ShimmerLaber.m
//  LayerAnimation
//
//  Created by idechao on 2017/1/1.
//  Copyright © 2017年 idechao. All rights reserved.
//

#import "ShimmerLaber.h"

@interface ShimmerLaber () {
    CGFloat shimmerGap;
    CGFloat shimmerAnimationDuration;
}

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation ShimmerLaber

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        shimmerGap = 0.05;
        shimmerAnimationDuration = 2.0;
        
        [self p_startAnimation];
    }
    return self;
}

- (void)p_startAnimation {
    // 创建CAGradientLayer
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    
    // 设置梯度颜色
    self.gradientLayer.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor,
                                  (__bridge id)[UIColor whiteColor].CGColor,
                                  (__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor];
    // 设置梯度颜色的位置
    self.gradientLayer.locations = @[@(0), @(shimmerGap), @(shimmerGap*2)];
    
    // 这是颜色渐变的方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1, 0);
    
    // 设置为mask，iOS8之后，也可以设置self.maskView
    self.layer.mask = self.gradientLayer;
    
    // 做动画
    [self doAnimation];
}

- (void)doAnimation {
    [self.gradientLayer removeAnimationForKey:@"slide"];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = @[@(0), @(shimmerGap), @(shimmerGap*2)];
    animation.toValue   = @[@(1-shimmerGap*2), @(1-shimmerGap), @(1)];
    animation.duration  = shimmerAnimationDuration;
    animation.removedOnCompletion = YES;
    animation.delegate = (id)self;
    [self.gradientLayer addAnimation:animation forKey:@"slide"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self doAnimation];
    }
}

@end
