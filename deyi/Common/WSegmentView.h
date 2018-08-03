//
//  WSegmentView.h
//  Brahms
//
//  Created by Jack_Tao on 2018/4/19.
//  Copyright © 2018年 Jack_Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSegmentView;

@protocol WSegmentViewDelegate <NSObject>

@optional

- (void)wSegmentViewSelected:(NSInteger)index segmentView:(WSegmentView *)segmentView;

@end

@interface WSegmentView : UIView
{
    NSArray *_titles;
    
    UIView *_lineView;
}

@property (nonatomic, strong) UIButton *lastSelectBtn;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) UIColor *selectedBgColor;
@property (nonatomic, strong) UIColor *normalBgColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *normalTitleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) CGFloat linewidth;
@property (nonatomic, assign) BOOL showLine;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak) id<WSegmentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

//need = true  self.selectedIndex=0;  else self.selectedIndex=-1;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles initSelected:(BOOL)need;

@end
