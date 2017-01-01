//
//  GradientLayerChar.m
//  LayerAnimation
//
//  Created by idechao on 2017/1/1.
//  Copyright © 2017年 idechao. All rights reserved.
//

#import "GradientLayerChar.h"
#import "ShimmerLaber.h"

@interface GradientLayerChar ()

@end

@implementation GradientLayerChar

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ShimmerLaber *label = [[ShimmerLaber alloc] initWithFrame:CGRectMake(100, 160, 200, 60)];
    [self.view addSubview:label  ];
    label.text = @"> 滑动来解锁";
    
}

@end
