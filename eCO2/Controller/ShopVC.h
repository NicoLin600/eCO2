//
//  ShopVC.h
//  Carbon
//
//  Created by Nic on 28/09/2019.
//  Copyright © 2019 NicLin. All rights reserved.
//

#import "CViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopVC : CViewController

@property (nonatomic, assign)NSInteger currentPoint;

@end

@interface CShopCell : UITableViewCell

- (void)setStuffImageName:(NSString *)imageName name:(NSString *)name andPoints:(NSInteger)points;

@end

NS_ASSUME_NONNULL_END
