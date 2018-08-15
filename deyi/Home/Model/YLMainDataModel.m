//
//  YLMainDataModel.m
//  deyi
//  首页数据model
//  Created by Michael Yang on 2018/8/15.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLMainDataModel.h"

@implementation YLMainDataModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"bannerArr":@"banner",
             @"navArr":@"nav",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"bannerArr":[Banner class],
             @"navArr":[Nav class],
             };
}

@end

@implementation More

@end

@implementation Banner

@end


@implementation Nav

@end

@implementation ActivityModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"listArr":@"list"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"listArr":[ActivityList class]};
}

@end

@implementation ActivityList


@end

@implementation RecommendModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"listArr":@"list"};
}

+ (NSDictionary *)modelCustomContainerGenericClass
{
    return @{@"listArr":[RecommendList class]};
}

@end


@implementation RecommendList

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID":@"id",@"typeId":@"typeid"};
}

@end

@implementation WeatherModel


@end


