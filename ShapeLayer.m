//
//  CASharpLayer.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/5.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "ShapeLayer.h"

@interface ShapeLayer ()

//@property (nonatomic, strong) UIView *containerView;

@end

@implementation ShapeLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:containerView];
    
    // create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100)
                    radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    // create shapr layer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 5;
    layer.lineJoin = kCALineJoinRound;
    layer.lineCap = kCALineCapRound;
    layer.path = path.CGPath;
    
    // add layer to view
    [containerView.layer addSublayer:layer];
    
    // 圆角
    
    // define path parameters
    CGRect rect = CGRectMake(0, 0, 100, 100);
    UIRectCorner corners = UIRectCornerTopRight |
                            UIRectCornerBottomRight | UIRectCornerBottomLeft;
    CGSize radii = CGSizeMake(30, 30);
    // create path
    UIBezierPath *corPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                  byRoundingCorners:corners
                                                        cornerRadii:radii];
    
    CAShapeLayer *cornerLayer = [CAShapeLayer layer];
    cornerLayer.frame = CGRectMake(100, 260, 100, 100);
    cornerLayer.path = corPath.CGPath;
    cornerLayer.fillColor = [UIColor blueColor].CGColor;
    [containerView.layer addSublayer:cornerLayer];
    
}

@end
