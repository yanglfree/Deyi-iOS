//
//  YLHomeRecommendAdTableViewCell.m
//  deyi
//
//  Created by Liang on 2018/8/16.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLHomeRecommendAdTableViewCell.h"

@interface YLHomeRecommendAdTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic, strong) RecommendList *recommendListModel;

@end

@implementation YLHomeRecommendAdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendListModel:(RecommendList *)recommendListModel
{
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:recommendListModel.img] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = recommendListModel.title;
}

@end
