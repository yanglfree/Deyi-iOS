//
//  YLHomeRecommendSingleImageTableViewCell.m
//  deyi
//
//  Created by Liang on 2018/8/16.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLHomeRecommendSingleImageTableViewCell.h"
#import "NSDate+WHDate.h"


@interface YLHomeRecommendSingleImageTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameAndDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property(nonatomic, strong) RecommendList *recommendSingleImageListModel;

@end

@implementation YLHomeRecommendSingleImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _avatarImageView.layer.cornerRadius = _avatarImageView.width / 2;
    _avatarImageView.layer.masksToBounds = YES;
}

- (void)setRecommendSingleImageListModel:(RecommendList *)recommendSingleImageListModel
{
    _titleLabel.text = recommendSingleImageListModel.title;
    _descLabel.text = recommendSingleImageListModel.intro;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:recommendSingleImageListModel.img] placeholderImage:PLACEHOLDER_IMAGE];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:recommendSingleImageListModel.uavatar] placeholderImage:PLACEHOLDER_IMAGE];
    _nameAndDateLabel.text = [NSString stringWithFormat:@"%@.%@", recommendSingleImageListModel.username,[NSDate timeInfoWithDate:[NSDate dateWithTimeIntervalSince1970:[recommendSingleImageListModel.thread_time doubleValue]]]];
}

@end
