//
//  JFDealWayHeaderCell.m
//  TableView
//
//  Created by Sun on 15/11/23.
//  Copyright © 2015年 Sun. All rights reserved.
//

#import "JFDealWaySubCell.h"

#define UnSelectedColor UIColorFromRGB(0x969696)
#define SelectedColor  UIColorFromRGB(0xf13838)
@interface JFDealWaySubCell ()

@end
@implementation JFDealWaySubCell
//
//- (UIImageView*)selectedIndicatorImg{
//    if (!_selectedIndicatorImg) {
//        _selectedIndicatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 16)];
//        [_selectedIndicatorImg setCenter:CGPointMake(17/2, self.bounds.size.height/2)];
//    }
//    return _selectedIndicatorImg;
//}

+ (instancetype)dealWaySubCellWithTable:(UITableView *)table
{
    static NSString *identifier = @"dealWaySubCellID";
    JFDealWaySubCell *cell = [table dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headerTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0,0)];
        [self.headerTitle setTextAlignment:NSTextAlignmentLeft];
        [self.headerTitle setText:@""];
        
        [self.headerTitle setTextColor:UnSelectedColor];
        [self.headerTitle setFont:[UIFont systemFontOfSize:13]];
        [self.bgView addSubview:self.headerTitle];
        
        self.headerSubTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.headerSubTitle setTextAlignment:NSTextAlignmentLeft];
        [self.headerSubTitle setText:@""];
        [self.headerSubTitle setTextColor:UnSelectedColor];
        [self.headerSubTitle setFont:[UIFont systemFontOfSize:13]];
        [self.bgView addSubview:self.headerSubTitle];
    }

    return  self;
}
- (void)setUserSelected:(BOOL)userSelected{
    [self.radioButton setSelected:userSelected];
   
    if (userSelected) {
         [self.headerTitle setTextColor:SelectedColor];
        [self.headerSubTitle setTextColor:SelectedColor];
    }else{
        [self.headerTitle setTextColor:UnSelectedColor];
        [self.headerSubTitle setTextColor:UnSelectedColor];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
     [self.selectedIndicatorImg setHidden:!selected];
//    if (self.isSelected) {
//        // 显示selectedIndicator and borderBg
//       
//        [self.borderBg setImage:[UIImage imageNamed:@"pruchase_CellSelected_Bg"]
//         ];
//    }else{
//        [self.borderBg setImage:[UIImage imageNamed:@"pruchase_CellUnSelected_Bg"]
//         ];
//    }
}
- (void)loadTitle:(NSString*)title subTitle:(NSString*)subTitle{
    [self.headerTitle setText:title];
    [self.headerSubTitle setText:subTitle];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    // 居中
    
    [self.headerTitle setFrame:CGRectMake(15, (self.bounds.size.height - 13)/2,130 , 13)];
    
    [self.headerSubTitle setFrame:CGRectMake(160, (self.bounds.size.height - 13)/2,80 , 13)];
    
    
}
@end
