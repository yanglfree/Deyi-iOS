//
//  Maroco.h
//  deyi
//
//  Created by Liang on 2018/8/2.
//  Copyright © 2018年 hipie. All rights reserved.
//

#ifndef Maroco_h
#define Maroco_h

//主要导航色
#define UI_MAIN_NAV_COLOR    [UIColor colorWithRed:219/255. green:118/255. blue:97/255. alpha:1]
#define UI_BG_DARK_GRAY [UIColor colorWithRed:250/255. green:250/255. blue:250/255. alpha:1]
#define UI_TEXT_DARK_GRAY [UIColor colorWithRed:153/255. green:153/255. blue:153/255. alpha:1]


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define TAB_BAR_HEIGHT 49

//弱引用
//WEAKSELF STRONGSELF
#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF __strong typeof(weakSelf) strongSelf = weakSelf;
#define STRONGSELF_OR_RET(_ret_) \
if (!weakSelf) return _ret_; \
__strong typeof(weakSelf) strongSelf = weakSelf;
#define WEAKSELF_OR_RET(_ret_) \
if (!weakSelf) return _ret_;

#define YLAppVersion  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



#endif /* Maroco_h */
