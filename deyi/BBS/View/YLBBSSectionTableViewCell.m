//
//  YLBBSSectionTableViewCell.m
//  deyi
//
//  Created by Michael Yang on 2018/8/16.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLBBSSectionTableViewCell.h"

@interface YLBBSSectionTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *favButton;

@property(nonatomic, strong) YLSectionModel *sectionModel;

@end

@implementation YLBBSSectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _logoImageView.layer.cornerRadius = _logoImageView.width / 2;
    _logoImageView.layer.masksToBounds = YES;
}

- (void)setSectionModel:(YLSectionModel *)sectionModel
{
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@(%@)",sectionModel.name,sectionModel.todayposts]];
    _titleLabel.attributedText = attStr;
    
    _descLabel.text = sectionModel.hotsubject;
    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:sectionModel.logo] placeholderImage:PLACEHOLDER_IMAGE];
}



- (IBAction)favAction:(id)sender {
    //添加收藏 关注
}

@end
