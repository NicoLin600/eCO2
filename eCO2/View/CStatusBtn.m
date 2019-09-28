//
//  CStatusBtn.m
//  eCO2
//
//  Created by Nic on 28/09/2019.
//  Copyright © 2019 NicLin. All rights reserved.
//

#import "CStatusBtn.h"

@interface CStatusBtn ()

@property (nonatomic, strong)UIImageView *bgView;

@end

@implementation CStatusBtn

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 150;
        self.layer.masksToBounds = YES;
        [self.titleLabel setFont:CFont(30)];
        self.backgroundColor = CBlackColor;
//        [self setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [self setTitleColor:CGreenColor forState:UIControlStateNormal];
        [self setTitle:@"START" forState:UIControlStateNormal];
        [self setTitleColor:CRedColor forState:UIControlStateSelected];
        [self setTitle:@"STOP" forState:UIControlStateSelected];
        [self addTarget:self action:@selector(statusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self insertSubview:self.bgView belowSubview:self.titleLabel];
    }
    return self;
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.image = [UIImage imageNamed:@"button"];
    }
    return _bgView;
}

- (void)statusBtnDidClick {
    self.selected = !self.selected;
    if (self.selected) {
        [self rotateBgView];
    }
    else {
        [self.bgView.layer removeAllAnimations];
    }
}

- (void)rotateBgView
{
    //动画
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = ULLONG_MAX;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.fillMode = kCAFillModeBoth;
    [self.bgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
@end
