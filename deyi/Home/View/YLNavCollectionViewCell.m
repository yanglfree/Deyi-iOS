//
//  YLNavCollectionViewCell.m
//  deyi
//
//  Created by Michael Yang on 2018/8/16.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLNavCollectionViewCell.h"

@interface YLNavCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *navImageView;
@property (weak, nonatomic) IBOutlet UILabel *navNameLabel;

@end

@implementation YLNavCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setNavModel:(Nav *)navModel
{
    [_navImageView sd_setImageWithURL:[NSURL URLWithString:navModel.pic] placeholderImage:[UIImage imageNamed:@""]];
    _navNameLabel.text = navModel.name;
}

@end
