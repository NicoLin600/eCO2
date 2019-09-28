//
//  CSlider.m
//  Carbon
//
//  Created by Nic on 28/09/2019.
//  Copyright © 2019 NicLin. All rights reserved.
//

#import "CSlider.h"

@interface CSlider ()

@property (nonatomic, strong)CALayer * colorLayer;

@end

@implementation CSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES;
        
        self.minimumValue = -1.0;
        self.maximumValue = 1.0;
        self.value = 0.0f;
        self.minimumTrackTintColor = CBlackColor;
        self.maximumTrackTintColor = CBlackColor;
        self.thumbTintColor = [UIColor clearColor];
        
        CALayer *lineLayer = [CALayer layer];
        lineLayer.size = CGSizeMake(2, self.layer.height);
        lineLayer.position = CGPointMake(self.width/2, self.layer.height/2);
        lineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        lineLayer.zPosition = 10;
        [self.layer addSublayer:lineLayer];
        
        [self.layer addSublayer:self.colorLayer];
    }
    return self;
}

- (CALayer *)colorLayer {
    if (!_colorLayer) {
        _colorLayer = [CALayer layer];
        _colorLayer.size = CGSizeMake(0, self.layer.height);
        _colorLayer.position = CGPointMake(self.width/2, self.layer.height/2);
        _colorLayer.backgroundColor = [UIColor clearColor].CGColor;
        _colorLayer.zPosition = 9;
    }
    return _colorLayer;
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
}

- (void)setValue:(float)value {
    [super setValue:value];
    
    UIColor *color = [UIColor clearColor];
    CGSize size = CGSizeMake(0, self.layer.height);
    CGPoint position = CGPointMake(self.width/2, self.layer.height/2);
    if (value < 0) {
        color = CRedColor;
        size = CGSizeMake(self.layer.width/2*fabsf(value), size.height);
        position =CGPointMake(self.width/2-size.width/2, self.layer.height/2);
    }
    else if (value > 0) {
        color = CGreenColor;
        size = CGSizeMake(self.layer.width/2*fabsf(value), size.height);
        position =CGPointMake(self.width/2+size.width/2, self.layer.height/2);
    }

    self.colorLayer.backgroundColor = color.CGColor;
    self.colorLayer.size = size;
    self.colorLayer.position = position;
}

@end
