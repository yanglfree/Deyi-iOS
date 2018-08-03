//
//  WSegmentView.m
//  Brahms
//
//  Created by Jack_Tao on 2018/4/19.
//  Copyright © 2018年 Jack_Tao. All rights reserved.
//

#import "WSegmentView.h"

@implementation WSegmentView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    return [self initWithFrame:frame titles:titles initSelected:YES];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles initSelected:(BOOL)need
{
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _selectedIndex = -1;
        _titleFont = [UIFont systemFontOfSize:12];
        _borderColor = [UIColor whiteColor];
        _selectedTitleColor = UI_MAIN_NAV_COLOR;
        _normalTitleColor = [UIColor whiteColor];
        _selectedBgColor = [UIColor whiteColor];
        _normalBgColor = UI_MAIN_NAV_COLOR;
        
        _lineColor = UI_MAIN_NAV_COLOR;
        _linewidth = 15;
        _lineHeight = 2;
        _showLine = NO;
        [self commonInitViews:frame.size];
        
        if (need) {
            self.selectedIndex = 0;
        }
        
    }
    return self;
}

- (void)commonInitViews:(CGSize)size
{
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat itemW = width/_titles.count;
    
    for (NSInteger i = 0; i < _titles.count; i++) {
        NSString *title = _titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*itemW, 0, itemW, height);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:_normalTitleColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setBackgroundColor:_normalBgColor];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(buttonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = _lineColor;
    _lineView.frame = CGRectMake(-16, 0, 16, 2);
    [self addSubview:_lineView];
    _lineView.hidden = YES;
    
    
}

#pragma mark setter
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
//    if (_selectedIndex == selectedIndex) {
//        return;
//    }
    
    if (selectedIndex == -1) {
        if (_lastSelectBtn) {
            [_lastSelectBtn setTitleColor:_normalTitleColor forState:UIControlStateNormal];
            [_lastSelectBtn setBackgroundColor:_normalBgColor];
            [_lastSelectBtn setTitle:_titles[_selectedIndex] forState:UIControlStateNormal];
        }
        _lastSelectBtn = nil;
        _selectedIndex = selectedIndex;
        _lineView.frame = CGRectMake(-16, 0, 16, 2);
        return;
    }
    
    UIButton *btn = (UIButton *)[self viewWithTag:selectedIndex+10];
    if (btn) {
        [btn setTitleColor:_selectedTitleColor forState:UIControlStateNormal];
        [btn setBackgroundColor:_selectedBgColor];
    }
    if (_lastSelectBtn && _lastSelectBtn != btn) {
        [_lastSelectBtn setTitleColor:_normalTitleColor forState:UIControlStateNormal];
        [_lastSelectBtn setBackgroundColor:_normalBgColor];
        [_lastSelectBtn setTitle:_titles[_selectedIndex] forState:UIControlStateNormal];
    }
    _selectedIndex = selectedIndex;
    _lastSelectBtn = btn;
    
    CGRect frame = btn.frame;
    _lineView.center = CGPointMake(CGRectGetMidX(frame), self.frame.size.height-1);
    
    if (_delegate && [_delegate respondsToSelector:@selector(wSegmentViewSelected:segmentView:)]) {
        [_delegate wSegmentViewSelected:_selectedIndex segmentView:self];
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.cornerRadius = 4;
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
    
}

- (void)setSelectedBgColor:(UIColor *)selectedBgColor
{
    _selectedBgColor = selectedBgColor;
    //self.selectedIndex = _selectedIndex;
    [self reloadItems];
}

- (void)setNormalBgColor:(UIColor *)normalBgColor
{
    _normalBgColor = normalBgColor;
    //self.selectedIndex = _selectedIndex;
    [self reloadItems];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    [self reloadItems];
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor
{
    _normalTitleColor = normalTitleColor;
    [self reloadItems];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [self reloadItems];
}

- (void)setShowLine:(BOOL)showLine
{
    _showLine = showLine;
    _lineView.hidden = !_showLine;
}

- (void)reloadItems
{
    for (NSInteger i = 0; i < _titles.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i+10];
        if (i != _selectedIndex) {
            [btn setTitleColor:_normalTitleColor forState:UIControlStateNormal];
            [btn setBackgroundColor:_normalBgColor];
        }else{
            [btn setTitleColor:_selectedTitleColor forState:UIControlStateNormal];
            [btn setBackgroundColor:_selectedBgColor];
        }
        btn.titleLabel.font = _titleFont;
    }
}

#pragma mark actions
- (void)buttonItemClicked:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    if (tag-10 >= 0) {
        self.selectedIndex = tag-10;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
