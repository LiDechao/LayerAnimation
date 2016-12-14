//
//  ReplicatorLayer3.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/14.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "ReplicatorLayer3.h"
#import "ReplicatorView3.h"

@interface ReplicatorLayer3 ()

@property (nonatomic, strong) CALayer *imageLayer;

@end

@implementation ReplicatorLayer3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // controller中进行绘制
    [self test];
    
    // 在view中绘制
//    [self test2];
}

- (void)test2 {
    UIImage *image = [UIImage imageNamed:@"fireballoon"];
    ReplicatorView3 *repView = [[ReplicatorView3 alloc] initWithFrame:CGRectMake(0, 80, image.size.width, image.size.height)];
    [self.view addSubview:repView];
}

- (void)test {
    UIImage *image = [UIImage imageNamed:@"fireballoon"];
    
    // 定义ReplicatorLayer
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    [layer setBounds:CGRectMake(0, 0, image.size.width, image.size.height * 1.5)];
    layer.masksToBounds =  YES;
    layer.anchorPoint = CGPointMake(0.5, 0.0);  // 设置锚点为layer的中间上面部分
    layer.position = CGPointMake(self.view.frame.size.width/2, 80.0); // 设置坐标
    layer.instanceCount = 2;
    [self.view.layer addSublayer:layer];
    
    // 设置图片的翻转并移动到合适的位置
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, 1.0, -1.0, 1.0);
    transform = CATransform3DTranslate(transform, 0, -[image size].height * 2, 1.0);
    
    layer.instanceTransform = transform;
    
    // 设置子layer
    _imageLayer = [CALayer layer];
    [_imageLayer setContentsScale:[[UIScreen mainScreen] scale]];
    [_imageLayer setContents:(__bridge id)image.CGImage];
    [_imageLayer setBounds:CGRectMake(0.0, 0.0, [image size].width, [image size].height)];
    [_imageLayer setAnchorPoint:CGPointMake(0, 0)];
    
    [layer addSublayer:_imageLayer];
    
    // 查看动态的效果
#if 1
    CATextLayer *textLayer = [CATextLayer layer];
    [textLayer setString:@"Click me"];
    [textLayer setFontSize:18];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setShadowColor:[UIColor blackColor].CGColor];
    [textLayer setShadowOpacity:1.0];
    [textLayer setShadowOffset:CGSizeMake(-4, -4)];
    [textLayer setBounds:CGRectMake(0, 0, _imageLayer.frame.size.width, 30)];
    [textLayer setPosition:CGPointMake(_imageLayer.frame.size.width/2, _imageLayer.frame.size.height - 20)];
    [_imageLayer addSublayer:textLayer];
    [self.view setUserInteractionEnabled:YES];
    [self.view setMultipleTouchEnabled:YES];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateTextLayer:)]];
#endif
}

- (void)animateTextLayer:(id)animateTextLayer {
    CALayer *textLayer = [[_imageLayer sublayers] objectAtIndex:0];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    CGFloat endPoint = [textLayer frame].size.height /2;
    
    //textLayer.position.y
    [animation setFromValue:[NSNumber numberWithFloat:textLayer.frame.origin.y + endPoint]];
    [animation setToValue:[NSNumber numberWithFloat:endPoint]];
    [animation setDuration:3.0];
    [animation setRepeatCount:MAXFLOAT];
    [animation setAutoreverses:YES];
    
    [textLayer addAnimation:animation forKey:nil];
}

@end
