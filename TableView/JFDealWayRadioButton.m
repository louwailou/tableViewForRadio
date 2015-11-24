//
//  JFDealWayRadioButton.m
//  TableView
//
//  Created by Sun on 15/11/24.
//  Copyright © 2015年 Sun. All rights reserved.
//

#import "JFDealWayRadioButton.h"
@interface JFDealWayRadioButton ()

@property (nonatomic,strong)UIImage *btnImg;
@end

@implementation JFDealWayRadioButton

- (id)initWithFrame:(CGRect)frame andStyle:(JFDealWayButtonStyle)style{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnStyle = style;
        self.btnImg =  [UIImage imageNamed:@"pruchase_CellSelected_UnCheckedBtn"];
         [self setImage:self.btnImg forState:UIControlStateNormal];
        
    }
    return self;
}
- (void)setUp{
   

}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];

    if (selected) {
        switch (self.btnStyle) {
            case JFDealWayButtonStylePurchase:
                [self setImage:[UIImage imageNamed:@"pruchase_CellSelected_CheckedBtn"] forState:UIControlStateNormal];
                break;
            case JFDealWayButtonStyleChange:{
                [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                break;
            }
            default:
                break;
        }
    }else{
        switch (self.btnStyle) {
            case JFDealWayButtonStylePurchase:
                [self setImage:[UIImage imageNamed:@"pruchase_CellSelected_UnCheckedBtn"] forState:UIControlStateNormal];
                break;
            case JFDealWayButtonStyleChange:{
                [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                break;
            }
            default:
                break;
        }
    }
    [self layoutIfNeeded];
    
}
@end
