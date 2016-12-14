//
//  ReplicatorView3.m
//  LayerAnimation
//
//  Created by idechao on 2016/12/14.
//  Copyright © 2016年 idechao. All rights reserved.
//

#import "ReplicatorView3.h"

@implementation ReplicatorView3 {
    UIImageView *_imageView;
}

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.image = [UIImage imageNamed:@"fireballoon"];
        [self addSubview:_imageView];
        
        CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
        layer.instanceCount = 2;
        
        //move reflection instance below original and flip vertically
        CATransform3D transform = CATransform3DIdentity;
        CGFloat verticalOffset = self.bounds.size.height + 2;
        transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
        transform = CATransform3DScale(transform, 1, -1, 0);
        layer.instanceTransform = transform;
        
        //reduce alpha of reflection layer
        layer.instanceAlphaOffset = -0.6;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}


@end
