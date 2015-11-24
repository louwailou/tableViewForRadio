//
//  JFDealWayRadioButton.h
//  TableView
//
//  Created by Sun on 15/11/24.
//  Copyright © 2015年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,JFDealWayButtonStyle) {
    JFDealWayButtonStyleNone = 0,
    JFDealWayButtonStylePurchase = 1,// 购买流程使用的样式
    JFDealWayButtonStyleChange ,// 更改到期处理方式使用的样式
    
};
@interface JFDealWayRadioButton : UIButton
@property (nonatomic,assign)JFDealWayButtonStyle btnStyle;

- (id)initWithFrame:(CGRect)frame andStyle:(JFDealWayButtonStyle)style;
@end
