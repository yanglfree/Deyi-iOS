//
//  YLHomeActivityCollectionViewCell.m
//  deyi
//
//  Created by Liang on 2018/8/16.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLHomeActivityCollectionViewCell.h"

@interface YLHomeActivityCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *activityImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation YLHomeActivityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setCellWithModel:(ActivityList *)model
{
    [self.activityImage sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
}

@end
