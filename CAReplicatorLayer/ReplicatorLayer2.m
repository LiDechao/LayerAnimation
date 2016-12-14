
//
//  ReplicatorLayer2.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/14.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "ReplicatorLayer2.h"

@interface ReplicatorLayer2 ()

@end

@implementation ReplicatorLayer2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    
    // 左下的效果，三角形
    [self replicatorTriangle];
    
    // 左上角的效果，波纹
    [self replicatorCircle];
    
    // 右上的效果,三个点的等待条
    [self replicatorWave];
    
    // 左下，这起啥名
    [self replicatorGrid];
}

// 正方形
- (void)replicatorGrid {
    NSInteger column = 3;
    CGFloat between = 5.0;
    CGFloat radius = (100 - between * (column - 1))/column;
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self scaleAnimation1], [self alphaAnimation]];
    animationGroup.duration = 1.0;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = HUGE;
    [shape addAnimation:animationGroup forKey:@"groupAnimation"];
    
    CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
    replicatorLayerX.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerX.instanceDelay = 0.3;
    replicatorLayerX.instanceCount = column;
    replicatorLayerX.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, radius+between, 0, 0);
    [replicatorLayerX addSublayer:shape];
    
    CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(CGRectGetWidth(self.view.frame)-150, 350, 100, 100);
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = column;
    replicatorLayerY.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, radius+between, 0);
    [replicatorLayerY addSublayer:replicatorLayerX];
    
    [self.view.layer addSublayer:replicatorLayerY];
}

// 一圈圈波纹的效果
- (void)replicatorCircle {
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, 80, 80);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 80, 80)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.opacity = 0.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self alphaAnimation],[self scaleAnimation]];
    animationGroup.duration = 4.0;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = HUGE;
    [shape addAnimation:animationGroup forKey:@"animationGroup"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(50, 100, 80, 80);
    replicatorLayer.instanceDelay = 0.5;
    replicatorLayer.instanceCount = 8;
    [replicatorLayer addSublayer:shape];
    
    [self.view.layer addSublayer:replicatorLayer];
}

// 类似于加载的等待提示框
- (void)replicatorWave {
    CGFloat between = 5.0;
    CGFloat radius = (100-2*between)/3;
    
    // 子layer
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, (100-radius)/2, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    [shape addAnimation:[self scaleAnimation1] forKey:@"scaleAnimation"];
    
    // 复制图层
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(self.view.frame.size.width-150, 100, 100, 100);
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(between*2+radius,0,0);
    
    [replicatorLayer addSublayer:shape];
    
    [self.view.layer addSublayer:replicatorLayer];
}

// 三角形
- (void)replicatorTriangle {
    CGFloat radius = 100/4;
    CGFloat transX = 100 - radius;
    
    // 构建子layer
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.strokeColor = [UIColor redColor].CGColor;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.lineWidth = 1;
    [shape addAnimation:[self rotationAnimation:transX] forKey:@"rotateAnimation"];
    
    // 添加复制图层
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(50, 350, radius, radius);
    replicatorLayer.instanceDelay = 0.0;    // 可先将transform注释，设置此参数为0.3，查看移动的效果
    replicatorLayer.instanceCount = 3;
    [replicatorLayer addSublayer:shape];
    [self.view.layer addSublayer:replicatorLayer];

    // 添加transform效果
    CATransform3D trans3D = CATransform3DIdentity;
    trans3D = CATransform3DTranslate(trans3D, transX, 0, 0);
    trans3D = CATransform3DRotate(trans3D, 120.0*M_PI/180.0, 0.0, 0.0, 1.0); // 添加z轴的旋转
    replicatorLayer.instanceTransform = trans3D;
    
}

#pragma mark - base animation

// 添加移动的动画
- (CABasicAnimation *)rotationAnimation:(CGFloat)transX{
    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0);
    transform.fromValue = [NSValue valueWithCATransform3D:fromValue];
    
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, transX, 0.0, 0.0);
    
    transform.toValue = [NSValue valueWithCATransform3D:toValue];
    transform.autoreverses = NO;
    transform.repeatCount = HUGE;
    transform.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transform.duration = 0.8;
    return transform;
}

// 放大缩小效果
- (CABasicAnimation *)scaleAnimation1{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
    scale.autoreverses = YES;
    scale.repeatCount = HUGE;
    scale.duration = 0.6;
    return scale;
}

// 透明度
- (CABasicAnimation *)alphaAnimation{
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1.0);
    alpha.toValue = @(0.0);
    return alpha;
}

// scale效果
- (CABasicAnimation *)scaleAnimation{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    return scale;
}

@end
