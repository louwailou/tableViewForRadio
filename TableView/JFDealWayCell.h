//
//  JFDealWayCellTableViewCell.h
//  TableView
//
//  Created by Sun on 15/11/24.
//  Copyright © 2015年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFDealWayRadioButton.h"
typedef NS_ENUM (NSInteger,JFDealWayCellButtonStyle){
    JFDealWayHeaderCellNone = 0,
    JFDealWayHeaderCellCheckMark = 1,//
    JFDealWayHeaderCellCheckBTN = 2,//
    
};

@interface JFDealWayCell: UITableViewCell

@property (nonatomic,strong)UIView *bgView;//所有的视图全部添加在改view上，除了SelectedIndicatorImg;
@property (nonatomic,strong)UILabel * headerTitle;
@property (nonatomic,strong)UILabel * headerSubTitle;
@property (nonatomic,strong)UIImageView *borderBg;// 边框背景
@property (nonatomic,strong)UIImageView *selectedIndicatorImg;
@property (nonatomic,strong)JFDealWayRadioButton *radioButton;

/**
 *   currentIndex
 */
@property (nonatomic,copy)NSIndexPath* indexPath;

/**
 * The boolean value showing the receiver is expandable or not. The default value of this property is NO.
 */
@property (nonatomic, assign) BOOL isExpandable;

/**
 * The boolean value showing the receiver is expanded or not. The default value of this property is NO.
 */
@property (nonatomic, assign) BOOL isExpanded;

/**
 *  base on the style indicating which one to show btn or checkMark
 */
@property (nonatomic,assign) JFDealWayCellButtonStyle btnStyle;

/**
 *  / 标记radioButton 选中的状态  如果yes radio 为红色，字体也变红
 */
@property (nonatomic,assign) BOOL userSelected;

- (void)loadTitle:(NSString*)title subTitle:(NSString*)subTitle;

@end
