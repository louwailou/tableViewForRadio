//
//  JFDealWayCellTableViewCell.m
//  TableView
//
//  Created by Sun on 15/11/24.
//  Copyright © 2015年 Sun. All rights reserved.
//

#import "JFDealWayCell.h"


#define kIndicatorViewTag -1
@interface JFDealWayCell ()


@end
@implementation JFDealWayCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setIsExpandable:NO];
        [self setIsExpanded:NO];
        self.bgView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.bgView.layer setCornerRadius:3.0];
        [self.bgView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.bgView];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self.selectedIndicatorImg setHidden:!selected];
    // Configure the view for the selected state
}

static UIImage *_image = nil;
- (UIView *)expandableView
{
    if (!_image) {
        _image = [UIImage imageNamed:@"pruchase_CellSelected_RightDownIndicator"];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    button.frame = frame;
    
    [button setBackgroundImage:_image forState:UIControlStateNormal];
    
    return button;
}
- (UIButton*)radioButton{
    if (!_radioButton) {
        _radioButton = [[JFDealWayRadioButton alloc]initWithFrame:CGRectMake(0, 0, 14, 14) andStyle:JFDealWayButtonStylePurchase];
    }
    return _radioButton;
}
- (void)setIsExpandable:(BOOL)isExpandable
{
    if (isExpandable){
        [self.radioButton removeFromSuperview];
        
         [self setAccessoryView:[self expandableView]];
    }else{
        [[self expandableView] removeFromSuperview];
        
        [self setAccessoryView:[self radioButton]];
    }
    
    _isExpandable = isExpandable;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect accessoryFrame = self.accessoryView.frame;
    accessoryFrame.origin.x = accessoryFrame.origin.x - 10;
    [self.accessoryView setFrame:accessoryFrame];
    
    [self.bgView setFrame:CGRectMake(10,0, self.bounds.size.width-20, self.bounds.size.height)];
    
    
    if (self.isExpanded) {
        
//        if (![self containsIndicatorView])
//            [self addIndicatorView];
//        else {
//           // [self removeIndicatorView];
//           // [self addIndicatorView];
//        }
    }
}




- (UIImageView*)borderBg{
    if (!_borderBg) {
        _borderBg = [[UIImageView alloc] initWithFrame:self.bgView.bounds];
    }
    return _borderBg;
}
- (UIImageView*)selectedIndicatorImg{
    if (!_selectedIndicatorImg) {
        _selectedIndicatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 16)];
        [_selectedIndicatorImg setImage:[UIImage imageNamed:@"pruchase_CellSelected_LeftIndicator"]];
        [_selectedIndicatorImg setCenter:CGPointMake(17/2, self.bounds.size.height/2)];
        [self addSubview:_selectedIndicatorImg];
    }
    return _selectedIndicatorImg;
}

- (void)loadTitle:(NSString*)title subTitle:(NSString*)subTitle{
    [self.headerTitle setText:title];
    [self.headerSubTitle setText:subTitle];
}

@end
