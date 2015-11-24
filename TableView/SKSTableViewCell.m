//
//  SKSTableViewCell.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableViewCell.h"


@interface SKSTableViewCell ()

@end

@implementation SKSTableViewCell

+ (instancetype)dealWayCellWithTable:(UITableView *)table
{
    static NSString *identifier = @"SKSCellID";
    SKSTableViewCell *cell = [table dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headerTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, self.bounds.size.width, 15)];
        [self.headerTitle setTextAlignment:NSTextAlignmentLeft];
        [self.headerTitle setText:@""];
        [self.headerTitle setTextColor:UIColorFromRGB(0x000000)];
        [self.headerTitle setFont:[UIFont systemFontOfSize:14]];
        [self.bgView addSubview:self.headerTitle];
        
        self.headerSubTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.headerTitle.frame) + 5, self.bounds.size.width, 12)];
        [self.headerSubTitle setTextAlignment:NSTextAlignmentLeft];
        [self.headerSubTitle setText:@""];
        [self.headerSubTitle setTextColor:UIColorFromRGB(0xf13838)];
        [self.headerSubTitle setFont:[UIFont systemFontOfSize:12]];
        [self.bgView addSubview:self.headerSubTitle];
    }
    return self;
}
- (void)setUserSelected:(BOOL)userSelected{
    [self.radioButton setSelected:userSelected];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}



-  (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    if (self.isSelected) {
        // 显示selectedIndicator and borderBg
        [self.borderBg setImage:[UIImage imageNamed:@"pruchase_CellSelected_Bg"]
         ];
    }else{
        [self.borderBg setImage:[UIImage imageNamed:@"pruchase_CellUnSelected_Bg"]
         ];
    }
}
- (void)loadTitle:(NSString*)title subTitle:(NSString*)subTitle{
    [self.headerTitle setText:title];
    [self.headerSubTitle setText:subTitle];
}






@end
