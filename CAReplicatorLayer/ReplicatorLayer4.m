//
//  ReplicatorLayer4.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/15.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "ReplicatorLayer4.h"
#import "UIBezierPath+TextPaths.h"
#import <CoreFoundation/CoreFoundation.h>

@interface ReplicatorLayer4 ()

@end

@implementation ReplicatorLayer4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CFTimeInterval duration = 40;
    int count = 400;
    
    // 添加文字的path
    UIBezierPath *path = [UIBezierPath pathForString:@"clgchao" withFont:[UIFont italicSystemFontOfSize:50.0]];
    path.lineWidth = 2;
    
    // 添加layer
    CAShapeLayer *textPath = [CAShapeLayer layer];
    textPath.frame = CGRectMake(0, 0, 200, 200);
    textPath.position = self.view.center;
    textPath.geometryFlipped = true;
    textPath.path = path.CGPath;
    textPath.bounds = CGPathGetBoundingBox(textPath.path);
    textPath.geometryFlipped = YES;
//    textPath.fillColor = [UIColor whiteColor].CGColor;
//    textPath.strokeColor = [UIColor whiteColor].CGColor;
    textPath.fillColor = nil;
    textPath.strokeColor = nil;
    textPath.lineWidth = 1.0;
    [self.view.layer addSublayer:textPath];
    
    // 添加CAReplicatorLayer和副本layer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = textPath.bounds;
    [textPath addSublayer:replicatorLayer];

    // 被复制的layer
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(34, 5, 2, 2);
    layer.cornerRadius = 1;
    layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
    [replicatorLayer addSublayer:layer];
    
    replicatorLayer.instanceDelay = duration/(CFTimeInterval)(count);
    replicatorLayer.instanceCount = 400;
    
    replicatorLayer.instanceRedOffset = -0.005;
    replicatorLayer.instanceGreenOffset = -0.003;
    replicatorLayer.instanceBlueOffset = -0.001;
    
    CAKeyframeAnimation *positionAnmation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnmation.path = textPath.path;
    positionAnmation.duration = duration;
    positionAnmation.repeatCount = HUGE;
    
    [layer addAnimation:positionAnmation forKey:@""];
}

@end
