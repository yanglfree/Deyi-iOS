//
//  YLHomeRecommendViewController.m
//  deyi
//
//  Created by Liang on 2018/8/15.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLHomeRecommendViewController.h"
#import "ZJScrollPageView.h"
#import "YLMainDataModel.h"
#import "YLBannerNavTableViewCell.h"
#import "YLHomeActivityTableViewCell.h"
#import "YLHomeRecommendAdTableViewCell.h"
#import "YLHomeRecommendSingleImageTableViewCell.h"
#import "YLHomeRecommendMultiImageTableViewCell.h"

@interface YLHomeRecommendViewController ()<ZJScrollPageViewChildVcDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) YLMainDataModel *mainDataModel;
@property(nonatomic, strong) UITableView *tableview;

@end

@implementation YLHomeRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableview registerClass:[YLBannerNavTableViewCell class] forCellReuseIdentifier:NSStringFromClass([YLBannerNavTableViewCell class])];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([YLHomeActivityTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YLHomeActivityTableViewCell class])];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([YLHomeRecommendAdTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YLHomeRecommendAdTableViewCell class])];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([YLHomeRecommendSingleImageTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YLHomeRecommendSingleImageTableViewCell class])];
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([YLHomeRecommendMultiImageTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YLHomeRecommendMultiImageTableViewCell class])];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)initData
{
    WEAKSELF
    [[YLNetwork sharedNetwork] PostWithUrl:API_HOME_RECOMMEND params:@{@"city":@"武汉市"} successHander:^(NSDictionary *response) {
        weakSelf.mainDataModel = [YLMainDataModel yy_modelWithDictionary:response[@"data"]];
        if (weakSelf.mainDataModel == nil) {
            return;
        }
        [weakSelf.tableview reloadData];
    } failHander:^(NSError *error, NSInteger httpStatus, id response, NSString *msg) {
        NSLog(@"error is %@",msg);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return self.mainDataModel.recommend.listArr.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 340;
    }else if(indexPath.section == 1){
        return 220;
    }else{
        RecommendList *recommendListModel = self.mainDataModel.recommend.listArr[indexPath.row];
        return recommendListModel.ad ? 200 : recommendListModel.moreimgs.count == 0 ? 180 : 220;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLBannerNavTableViewCell class])];
        if (!cell) {
            cell = [[YLBannerNavTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([YLBannerNavTableViewCell class])];
        }
        [cell setValue:self.mainDataModel.navArr forKey:@"navArr"];
        [cell setValue:self.mainDataModel.bannerArr forKey:@"bannerArr"];
        
    }else if(indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLHomeActivityTableViewCell class])];
        if (!cell) {
            cell = [[YLHomeActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([YLHomeActivityTableViewCell class])];
        }
        [cell setValue:self.mainDataModel.activity forKey:@"activityModel"];
    }else if(indexPath.section == 2){
        
        RecommendList *list = self.mainDataModel.recommend.listArr[indexPath.row];
        if (list.ad) {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLHomeRecommendAdTableViewCell class])];
            if (!cell) {
                cell = [[YLHomeRecommendAdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([YLHomeRecommendAdTableViewCell class])];
            }
            [cell setValue:list forKey:@"recommendListModel"];
        }else{
            if (list.moreimgs != nil && list.moreimgs.count > 0) {
                //多图
                cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLHomeRecommendMultiImageTableViewCell class])];
                if (!cell) {
                    cell = [[YLHomeRecommendMultiImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([YLHomeRecommendMultiImageTableViewCell class])];
                }
                [cell setValue:list forKey:@"recommendMultiListModel"];
            }else{
                //单图
                cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLHomeRecommendSingleImageTableViewCell class])];
                if (!cell) {
                    cell = [[YLHomeRecommendSingleImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([YLHomeRecommendSingleImageTableViewCell class])];
                }
                [cell setValue:list forKey:@"recommendSingleImageListModel"];
            }
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        //
    }
}


@end
