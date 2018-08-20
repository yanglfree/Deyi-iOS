//
//  YLRefreshTableView.m
//  deyi
//
//  Created by Michael Yang on 2018/8/16.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLRefreshTableView.h"
#import <MJRefresh/MJRefresh.h>

@implementation YLRefreshTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self headerView];
        [self footerView];
    }
    return self;
}

- (void)headerView
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    self.mj_header = header;
}

- (void)footerView
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    self.mj_footer = footer
}

@end
