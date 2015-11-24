//
//  JFDealWayModel.m
//  TableView
//
//  Created by Sun on 15/11/24.
//  Copyright © 2015年 Sun. All rights reserved.
//

#import "JFDealWayModel.h"

@implementation JFDealWayModel

- (id)init{
    self = [super init];
    if (self) {
        self.subRowsModel = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
