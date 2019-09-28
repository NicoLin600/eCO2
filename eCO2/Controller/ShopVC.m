//
//  ShopVC.m
//  Carbon
//
//  Created by Nic on 28/09/2019.
//  Copyright © 2019 NicLin. All rights reserved.
//

#import "ShopVC.h"
#import "CMacroHeader.h"

@interface ShopVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UIView *topView;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSArray *datasourceArr;

@end

@implementation ShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
}

- (UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, CMainTopHeight)];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CEdgePadding, CTopTextPadding, 300.0f, 40.0f)];
        titleLabel.font = CFont(40);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = @"Shop";
        [_topView addSubview:titleLabel];
        
        UIButton *dismissBtn = [[UIButton alloc] init];
        [dismissBtn setImage:[UIImage imageNamed:@"dismiss"] forState:UIControlStateNormal];
        [dismissBtn addTarget:self action:@selector(dismissBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:dismissBtn];
        [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.and.width.mas_equalTo(44);
            make.bottom.and.right.equalTo(self->_topView).with.offset(-CEdgePadding);

        }];
        
        UILabel *pointLabel = [[UILabel alloc] init];
        pointLabel.font = CFont(20);
        pointLabel.textAlignment = NSTextAlignmentRight;
        pointLabel.textColor = CBlackColor;
        pointLabel.text = [NSString stringWithFormat:@"Points: %li", self.currentPoint];
        [_topView addSubview:pointLabel];
        [pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44.0f);
            make.right.equalTo(dismissBtn.mas_left).with.offset(-CEdgePadding);
            make.centerY.equalTo(dismissBtn).with.offset(5.0f);
        }];
    }
    return _topView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(CEdgePadding, CMainTopHeight+CEdgePadding*2, self.view.width-CEdgePadding*2, self.view.height-CMainTopHeight-CEdgePadding*3) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[CShopCell class] forCellReuseIdentifier:NSStringFromClass([CShopCell class])];
    }
    return _tableView;
}

- (NSArray *)datasourceArr {
    if (!_datasourceArr) {
        _datasourceArr = @[@{@"name":@"Iron Straw", @"points":@"5"},
                           @{@"name":@"Reusable Bag", @"points":@"10"},
                           @{@"name":@"Water Bottle", @"points":@"20"},
                           @{@"name":@"Tesla", @"points":@"99999999"}];
    }
    return _datasourceArr;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CShopCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CShopCell class]) forIndexPath:indexPath];
    NSDictionary *dic = self.datasourceArr[indexPath.row];
    NSInteger points = [dic[@"points"] integerValue];
    [cell setStuffImageName:(self.currentPoint >= points ? @"stuff_availble" : @"stuff_inavailble") name:dic[@"name"] andPoints:[dic[@"points"] floatValue]];
    return cell;
}

- (void)dismissBtnDidClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

@interface CShopCell ()

@property (nonatomic, strong)UIImageView *stuffView;
@property (nonatomic, strong)UILabel *nameLable;
@property (nonatomic, strong)UILabel *pointLable;

@end

@implementation CShopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CBlackColor;

        self.layer.cornerRadius = 10.0f;
        
        CGFloat edgePadding = 5.0f;
        CGFloat imageSize = self.contentView.height - edgePadding*2;
        self.stuffView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.stuffView];
        [self.stuffView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_equalTo(imageSize);
            make.left.equalTo(self.contentView).with.offset(CEdgePadding);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.nameLable = [[UILabel alloc] init];
        self.nameLable.font = CFont(20);
        self.nameLable.textAlignment = NSTextAlignmentRight;
        self.nameLable.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameLable];
        [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.stuffView.mas_right).with.offset(CEdgePadding);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.pointLable = [[UILabel alloc] init];
        self.pointLable.font = CFont(16);
        self.pointLable.textAlignment = NSTextAlignmentRight;
        self.pointLable.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.pointLable];
        [self.pointLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).with.offset(-CEdgePadding);
            make.centerY.equalTo(self.contentView);
        }];
        
    }
    return self;
}

//making segmentations.
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setStuffImageName:(NSString *)imageName name:(NSString *)name andPoints:(NSInteger)points {
    self.stuffView.image = [UIImage imageNamed:imageName];
    self.nameLable.text = name;
    self.pointLable.text = [NSString stringWithFormat:@"Points: %li", points];
}

@end
