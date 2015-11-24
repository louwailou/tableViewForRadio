//
//  JFDealWayModel.h
//  TableView
//
//  Created by Sun on 15/11/24.
//  Copyright © 2015年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFDealWayModel : NSObject
@property (nonatomic,copy) NSString * headerTitle;
@property (nonatomic,copy) NSString * headerSubTitle;
@property (nonatomic,strong) NSMutableArray * subRowsModel;
@end
