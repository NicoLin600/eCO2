//
//  ViewController.m
//  Carbon
//
//  Created by Nic on 28/09/2019.
//  Copyright © 2019 NicLin. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ShopVC.h"
#import "CStatusBtn.h"
#import "CSlider.h"

@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic, strong)UIView *topView;
@property (nonatomic, strong)UIButton *cartBtn;
@property (nonatomic, strong)UILabel *pointLabel;

@property (nonatomic, strong)CStatusBtn *statusBtn;
@property (nonatomic, strong)CSlider *balanceSlider; // for carbon saved

@property(nonatomic,retain)CLLocationManager *locationManager;

@property(nonatomic,retain)CLLocation *lastLocation;
@property(nonatomic,assign)CGFloat totalDistance;
@property(nonatomic,assign)CGFloat totalEmission;
@property(nonatomic,assign)CGFloat balance;
@property(nonatomic,assign)NSUInteger rewardPoints;
@property(nonatomic,assign)NSInteger penguines;

@property (nonatomic, strong)UIView *totalDistanceView;
@property (nonatomic, strong)UILabel *disLabel;

@property (nonatomic, strong)UIView *carbonView;
@property (nonatomic, strong)UILabel *carbonLabel;

@property (nonatomic, strong)UIImageView *penguineBar;
@property (nonatomic, strong)UILabel *penguineLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.topView];
    [self.view addSubview:self.statusBtn];
    [self.view addSubview:self.balanceSlider];
    [self.view addSubview:self.totalDistanceView];
    [self.view addSubview:self.carbonView];
    [self.view addSubview:self.penguineBar];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initData];
    [self initTracker];
}

- (void)initData {
    self.totalDistance = 0.00f;
    self.totalEmission = 0.00f;
    self.balance = 0.00f;
    self.rewardPoints = 0;
    self.penguines = 0;
}

- (UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CMainTopHeight)];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CEdgePadding, CTopTextPadding, 300.0f, 40.0f)];
        titleLabel.font = CFont(40);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = @"eCO2";
        [_topView addSubview:titleLabel];
        
        self.cartBtn = [[UIButton alloc] init];
        [self.cartBtn setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
        [self.cartBtn addTarget:self action:@selector(cartBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:self.cartBtn];
        [self.cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30.0f);
            make.bottom.and.right.equalTo(self->_topView).with.offset(-CEdgePadding);
        }];
        
        self.pointLabel = [[UILabel alloc] init];
        self.pointLabel.font = CFont(20);
        self.pointLabel.textAlignment = NSTextAlignmentRight;
        self.pointLabel.textColor = CBlackColor;
        self.pointLabel.text = @"0";
        [_topView addSubview:self.pointLabel];
        [self.pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44.0f);
            make.right.equalTo(self.cartBtn.mas_left).with.offset(-CEdgePadding);
            make.centerY.equalTo(self.cartBtn).with.offset(5.0f);
        }];
        
        UILabel *pointTitleLabel = [[UILabel alloc] init];
        pointTitleLabel.font = CFont(20);
        pointTitleLabel.textAlignment = NSTextAlignmentRight;
        pointTitleLabel.textColor = CBlackColor;
        pointTitleLabel.text = @"Points:";
        [_topView addSubview:pointTitleLabel];
        [pointTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44.0f);
            make.right.equalTo(self.pointLabel.mas_left).with.offset(-CEdgePadding);
            make.centerY.equalTo(self.pointLabel);
        }];
        
    }
    return _topView;
}

- (CStatusBtn *)statusBtn {
    if (!_statusBtn) {
        _statusBtn = [[CStatusBtn alloc] initWithFrame:CGRectMake(self.view.centerX-150, self.view.centerY-300, 300, 300)];
        [_statusBtn addTarget:self action:@selector(statusBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _statusBtn;
}

- (CSlider *)balanceSlider {
    if (!_balanceSlider) {
        _balanceSlider = [[CSlider alloc] initWithFrame:CGRectMake(CEdgePadding, self.view.centerY + 100, self.view.width - CEdgePadding*2, 50)];
    }
    return _balanceSlider;
}

- (UIView *)totalDistanceView {
    if (!_totalDistanceView) {
        _totalDistanceView =[[UIView alloc] initWithFrame:CGRectMake(CEdgePadding, self.view.centerY + 200, (self.view.width - CEdgePadding*3)/2, 100)];
        _totalDistanceView.backgroundColor = CBlackColor;
        _totalDistanceView.layer.cornerRadius = 10.0f;
        
        UILabel * disTitle = [[UILabel alloc] init];
        disTitle.textColor = [UIColor lightGrayColor];
        disTitle.textAlignment = NSTextAlignmentLeft;
        disTitle.font = CFont(16);
        disTitle.text = @"Total Distance:";
        [_totalDistanceView addSubview:disTitle];
        [disTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.equalTo(self->_totalDistanceView).with.offset(CEdgePadding);
        }];
        
        self.disLabel = [[UILabel alloc] init];
        self.disLabel.textColor = [UIColor whiteColor];
        self.disLabel.font = CFont(30);
        self.disLabel.textAlignment = NSTextAlignmentRight;
        self.disLabel.text = [NSString stringWithFormat:@"%.2f km.", self.totalDistance];
        [_totalDistanceView addSubview:self.disLabel];
        [self.disLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.and.right.equalTo(self->_totalDistanceView).with.offset(-CEdgePadding);
        }];
    }
    return _totalDistanceView;
}

- (UIView *)carbonView {
    if (!_carbonView) {
        _carbonView =[[UIView alloc] initWithFrame:CGRectMake(self.view.centerX + CEdgePadding/2, self.view.centerY + 200, (self.view.width - CEdgePadding*3)/2, 100)];
        _carbonView.backgroundColor = CBlackColor;
        _carbonView.layer.cornerRadius = 10.0f;

        UILabel * carbonTitle = [[UILabel alloc] init];
        carbonTitle.textColor = [UIColor lightGrayColor];
        carbonTitle.textAlignment = NSTextAlignmentLeft;
        carbonTitle.font = CFont(16);
        carbonTitle.text = @"CO2 Emitted:";
        [_carbonView addSubview:carbonTitle];
        [carbonTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.equalTo(self->_carbonView).with.offset(CEdgePadding);
        }];
        
        self.carbonLabel = [[UILabel alloc] init];
        self.carbonLabel.textColor = [UIColor whiteColor];
        self.carbonLabel.font = CFont(30);
        self.carbonLabel.textAlignment = NSTextAlignmentRight;
        self.carbonLabel.text = [NSString stringWithFormat:@"%.2f kg.", self.totalEmission];
        [_carbonView addSubview:self.carbonLabel];
        [self.carbonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.and.right.equalTo(self->_carbonView).with.offset(-CEdgePadding);
        }];
    }
    return _carbonView;
}

- (UIImageView *)penguineBar {
    if (!_penguineBar) {
        _penguineBar = [[UIImageView alloc] initWithFrame:CGRectMake(CEdgePadding, self.view.centerY + 350, self.view.width - CEdgePadding*2, 50.0f)];
        _penguineBar.backgroundColor = [UIColor clearColor];
        _penguineBar.image = [UIImage imageNamed:@"ice"];
        UIImageView * penguineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -CEdgePadding*2, 80.0f, 80.0f)];
        penguineImageView.image = [UIImage imageNamed:@"penguine"];
        [_penguineBar addSubview:penguineImageView];
        
        self.penguineLabel = [[UILabel alloc] init];
        self.penguineLabel.textColor = [UIColor whiteColor];
        self.penguineLabel.font = CFont(16);
        self.penguineLabel.textAlignment = NSTextAlignmentRight;
        [_penguineBar addSubview:self.penguineLabel];
        [self.penguineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(penguineImageView.mas_right).with.offset(CEdgePadding);
            make.centerY.equalTo(self->_penguineBar);
        }];
        
    }
    return _penguineBar;
}

- (void)setTotalDistance:(CGFloat)totalDistance {
    _totalDistance = totalDistance;
    _disLabel.text = [NSString stringWithFormat:@"%.2f km.", totalDistance];
}

- (void)setTotalEmission:(CGFloat)totalEmission {
    _totalEmission = totalEmission;
    _carbonLabel.text = [NSString stringWithFormat:@"%.2f kg.", totalEmission];
}

- (void)setBalance:(CGFloat)balance {
    _balance = balance;
    _balanceSlider.value = balance;
}

- (void)setRewardPoints:(NSUInteger)rewardPoints {
    _rewardPoints = rewardPoints;
    _pointLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)rewardPoints];
}

- (void)setPenguines:(NSInteger)penguines {
    _penguines = penguines;
    
    _penguineLabel.text = [[[@"You have " stringByAppendingString:(penguines >= 0 ? @"saved " : @"killed ")] stringByAppendingString:[NSString stringWithFormat:@"%li ", labs(penguines)]] stringByAppendingString:(penguines == 1 ? @"penguine." : @"penguines.")];
}

- (void)initTracker {
    if ([CLLocationManager locationServicesEnabled] == NO) {
        return ;
    }
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

#pragma marks - btn action
- (void)cartBtnDidClick {
    
    ShopVC *shopVC = [[ShopVC alloc] init];
    shopVC.currentPoint = self.rewardPoints;
    [self.navigationController presentViewController:shopVC animated:YES completion:nil];
}

- (void)statusBtnDidClick:(UIButton *)sender {
    if (!sender.selected) {
        [self.locationManager stopUpdatingLocation];

        self.rewardPoints = [self getRewardPointsByBalance:self.balance];
        self.penguines = [self getSavedPenguinesByBalance:self.balance];
        
    }
    else {
        self.totalDistance = 0.0f;
        self.totalEmission = 0.0f;
        self.balance = 0.0f;
//        self.lastLocation = nil;
        [self.locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentlocation = locations.lastObject;
    CGFloat speed = currentlocation.speed;
    if (speed < 0) {
        speed = 0;
    }
    
    NSTimeInterval age = -[currentlocation.timestamp timeIntervalSinceNow];
    if (age > 120) return;    // ignore old (cached) updates
    if (currentlocation.horizontalAccuracy < 0) return;   // ignore invalid udpates
    
    // EDIT: need a valid oldLocation to be able to compute distance
    if (self.lastLocation == nil || self.lastLocation.horizontalAccuracy < 0) {
        self.lastLocation = currentlocation;
        return;
    }
    CGFloat currentDistance = [currentlocation distanceFromLocation:self.lastLocation];
    self.totalDistance += (currentDistance/1000.0f);
    CGFloat currentEmission = [self getCO2EmissionBySpeed:speed distance:currentDistance andVehicleType:CBus];
    self.totalEmission += currentEmission;
    self.balance += [self getBalanceByTotalEmission:currentEmission andDistance:currentDistance];

    self.lastLocation = currentlocation;
}

- (CGFloat)getCO2EmissionBySpeed:(CGFloat)speed distance:(CGFloat)distance andVehicleType:(CVehicleType)vehicleType {
    CGFloat emission =0.00f;
    if (speed > 5.0f) {
        CGFloat vehichleWeight = [self getVehicleWeightByType:vehicleType];
        emission = vehichleWeight*distance/1000000.0f;
    }
    return emission;
}

- (CGFloat)getBalanceByTotalEmission:(CGFloat)totalEmission andDistance:(CGFloat)distance {
    return [self getVehicleWeightByType:CCar]*distance/1000000.0f-totalEmission;
}

- (NSUInteger)getRewardPointsByBalance:(CGFloat)balance {
    NSUInteger rewardPoints = 0;
    if (balance > 0) {
        rewardPoints = balance*10;
    }
    return rewardPoints;
}

- (CGFloat)getSavedPenguinesByBalance:(CGFloat)balance {
    CGFloat penguines = 0;
    penguines = balance*5;
    return penguines;
}

- (CGFloat)getVehicleWeightByType:(CVehicleType)vehicleType {
    CGFloat weight = 0;
    switch (vehicleType) {
        case CCar:
        {
            weight = 1300;
        }
            break;
        case CBus:
        {
            weight = 800;
        }
            break;
        case CSUV:
        {
            weight = 1600;
        }
            break;
        default:
            break;
    }
    
    return weight;
}


@end
