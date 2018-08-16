//
//  YLHomeRecommendMultiImageTableViewCell.m
//  deyi
//
//  Created by Liang on 2018/8/16.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLHomeRecommendMultiImageTableViewCell.h"
#import "YLMainDataModel.h"

@interface YLHomeRecommendMultiImageTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pic1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pic2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pic3ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameAndDateLabel;
@property(nonatomic, strong) RecommendList *recommendMultiListModel;

@end

@implementation YLHomeRecommendMultiImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _avatarImageView.layer.cornerRadius = _avatarImageView.width / 2;
    _avatarImageView.layer.masksToBounds = YES;
}

- (void)setRecommendMultiListModel:(RecommendList *)recommendMultiListModel
{
    _titleLabel.text = recommendMultiListModel.title;
    _descLabel.text = recommendMultiListModel.intro;
    [_pic1ImageView sd_setImageWithURL:[NSURL URLWithString:recommendMultiListModel.moreimgs[0]] placeholderImage:PLACEHOLDER_IMAGE];
    [_pic2ImageView sd_setImageWithURL:[NSURL URLWithString:recommendMultiListModel.moreimgs[1]] placeholderImage:PLACEHOLDER_IMAGE];
    [_pic3ImageView sd_setImageWithURL:[NSURL URLWithString:recommendMultiListModel.moreimgs[2]] placeholderImage:PLACEHOLDER_IMAGE];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:recommendMultiListModel.uavatar] placeholderImage:PLACEHOLDER_IMAGE];
    _nameAndDateLabel.text = [NSString stringWithFormat:@"%@ . %@",recommendMultiListModel.username,recommendMultiListModel.thread_time];
}

@end
