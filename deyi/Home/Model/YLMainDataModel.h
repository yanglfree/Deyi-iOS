//
//  YLMainDataModel.h
//  deyi
//  首页数据model
//  Created by Michael Yang on 2018/8/15.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ActivityModel, WeatherModel, RecommendModel, Banner, Nav;

@interface YLMainDataModel : NSObject

@property(nonatomic, copy) NSArray<Banner *> *bannerArr;
@property(nonatomic, copy) NSArray<Nav *> *navArr;
@property(nonatomic, strong) ActivityModel *activity;
@property(nonatomic, strong) WeatherModel *weather;
@property(nonatomic, strong) RecommendModel *recommend;
@property(nonatomic, copy) NSString *dotnum;
@property(nonatomic, copy) NSString *total;

@end

@interface More : NSObject

@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *attr;

@end

@interface Banner : NSObject

@property(nonatomic, copy) NSString *pic;
@property(nonatomic, strong) More *jumpto;

@end

@interface Nav : NSObject

@property(nonatomic, copy) NSString *pic;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) More *jumpto;

@end

@interface ActivityList : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *pic;
@property(nonatomic, strong) More *jumpto;

@end

@interface ActivityModel : NSObject

@property(nonatomic, copy) NSArray<ActivityList *> *listArr;
@property(nonatomic, strong) More *more;

@end

@interface WeatherModel : NSObject

@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *temp;
@property(nonatomic, copy) NSString *pm25;
@property(nonatomic, strong) More *jumpto;
@property(nonatomic, copy) NSString *area;
@property(nonatomic, copy) NSString *weather;
@property(nonatomic, copy) NSString *temp2;
@property(nonatomic, copy) NSString *weather2;

@end

@interface RecommendList : NSObject

@property(nonatomic, copy) NSString *ID;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *tid;
@property(nonatomic, copy) NSString *fid;
@property(nonatomic, copy) NSString *typeId;
@property(nonatomic, copy) NSString *authorid;
@property(nonatomic, copy) NSString *img;
@property(nonatomic, copy) NSString *img2;
@property(nonatomic, copy) NSArray *moreimgs;
@property(nonatomic, copy) NSString *intro;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *sort;
@property(nonatomic, copy) NSString *attr;
@property(nonatomic, copy) NSString *jumptype;
@property(nonatomic, copy) NSString *jumpattr;
@property(nonatomic, copy) NSString *pubtime;
@property(nonatomic, copy) NSString *taskid;
@property(nonatomic, copy) NSString *thread_time;
@property(nonatomic, assign) BOOL ad;
@property(nonatomic, copy) NSString *fixed_pos;
@property(nonatomic, copy) NSString *referrer;
@property(nonatomic, copy) NSString *auditor;
@property(nonatomic, copy) NSString *areaname;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, assign) NSUInteger noneauthor;
@property(nonatomic, copy) NSString *uavatar;
@property(nonatomic, copy) NSString *rectime;
@property(nonatomic, copy) NSString *replies;
@property(nonatomic, copy) NSString *views;
@property(nonatomic, copy) NSString *fname;
@property(nonatomic, assign) BOOL isvideo;
@property(nonatomic, copy) NSString *tag;
@property(nonatomic, strong) More *jumpto;

@end

@interface RecommendModel : NSObject

@property(nonatomic, copy) NSArray<RecommendList *> *listArr;
@property(nonatomic, copy) NSString *nextpage;

@end
