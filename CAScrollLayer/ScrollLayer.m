//
//  ScrollLayer.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/20.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "ScrollLayer.h"

@interface ScrollLayer ()

@property (nonatomic, strong) CAScrollLayer *scrollLayer;

@end

@implementation ScrollLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:@"bg.jpg"].CGImage;
    layer.frame = CGRectMake(80, 80, 100, 100);
    
    self.scrollLayer = [CAScrollLayer layer];
    self.scrollLayer.frame = CGRectMake(60, 80, 200, 200);
    self.scrollLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.scrollLayer addSublayer:layer];
    self.scrollLayer.scrollMode = kCAScrollBoth;
    [self.view.layer addSublayer:self.scrollLayer];
    
    // 这个判断只是判断手势，可以先判断出发点是否在当前的大小里再去响应手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
    //get the offset by subtracting the pan gesture
    //translation from the current bounds origin
    CGPoint offset = self.scrollLayer.bounds.origin;
    offset.x -= [recognizer translationInView:self.view].x;
    offset.y -= [recognizer translationInView:self.view].y;
    
    //scroll the layer
    [self.scrollLayer scrollToPoint:offset];
    
    //reset the pan gesture translation
    [recognizer setTranslation:CGPointZero inView:self.view];
}

@end
