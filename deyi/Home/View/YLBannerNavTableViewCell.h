//
//  YLBannerTableViewCell.h
//  deyi
//
//  Created by Michael Yang on 2018/8/15.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLMainDataModel.h"

@interface YLBannerNavTableViewCell : UITableViewCell

@property(nonatomic, copy) void (^bannerImageClick)(More *jumpto);

@property(nonatomic, copy) NSArray<Banner *> *bannerArr;
@property(nonatomic, copy) NSArray<Nav *> *navArr;

@end
