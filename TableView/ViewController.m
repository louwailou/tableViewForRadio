//
//  ViewController.m
//  TableView
//
//  Created by Sun on 15/11/23.
//  Copyright © 2015年 Sun. All rights reserved.
//

#import "ViewController.h"
#import "SKSTableViewCell.h"
#import "JFDealWaySubCell.h"
#import "SKSTableView.h"
#import "JFDealWayModel.h"
#import "JFDealWaySubModel.h"
#import "JFDealWayCellFooterView.h"
@interface ViewController ()<SKSTableViewDelegate>
@property (nonatomic,strong)SKSTableView* tableView;
@property (nonatomic, strong) NSMutableArray *contentsForSection;

@end

@implementation ViewController
- (NSMutableArray *)contentsForSection
{
    if (!_contentsForSection) {
        _contentsForSection = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _contentsForSection;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i =0; i< 5; i++) {
        JFDealWayModel * model = [[JFDealWayModel alloc] init];
        model.headerSubTitle = @"到期后本金部分自动据需投入";
        model.headerTitle = @"本息续投";
        for (int j=0; j < 4; j++) {
            if (i == 1 || i == 2) {
                JFDealWaySubModel *subModel = [[JFDealWaySubModel alloc]init];
                subModel.rowTitle = @"短促有力(30天)";
                subModel.rowSubTitle = @"15.7%";
                [model.subRowsModel addObject:subModel];
            }
        }
        [self.contentsForSection addObject:model];
    }
    
    
    self.tableView = [[SKSTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width , self.view.bounds.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.SKSTableViewDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contentsForSection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    JFDealWayModel * model = [self.contentsForSection objectAtIndex:section];
//    
//    return [model.subRowsModel count]+1;
    return 1;
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    JFDealWayModel * model = [self.contentsForSection objectAtIndex:indexPath.section];
    
    return [model.subRowsModel count];
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
        SKSTableViewCell *cell = [SKSTableViewCell dealWayCellWithTable:tableView];
        
        // cell.textLabel.text = self.contents[indexPath.section+1][indexPath.row][0];
        
        if ((indexPath.section == 1 && indexPath.row == 0) || (indexPath.section == 2 && indexPath.row == 0 ))
            cell.isExpandable = YES;
        else
            cell.isExpandable = NO;
        
        cell.indexPath = indexPath;
    if (indexPath.section != 0) {
        
        JFDealWayModel * model = [self.contentsForSection objectAtIndex:indexPath.section -1 ];
        [cell loadTitle:model.headerTitle subTitle:model.headerSubTitle];
    }else {
        [cell loadTitle:@"" subTitle:@""];
    }
        return cell;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JFDealWaySubCell *cell = [JFDealWaySubCell dealWaySubCellWithTable:tableView];
    cell.indexPath = indexPath;
    
    if (indexPath.section !=0) {
        JFDealWayModel * model = [self.contentsForSection objectAtIndex:indexPath.section ];
        
        if (indexPath.row <= [model.subRowsModel count]) {
            JFDealWaySubModel * subModel = [model.subRowsModel objectAtIndex:indexPath.row - 1];
            [cell loadTitle:subModel.rowTitle subTitle:subModel.rowSubTitle];
        }
        
        
    }
    

    
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSInteger count = [ self.contentsForSection count];
    if (section == count -1) {
        JFDealWayCellFooterView *view = [[JFDealWayCellFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 106)];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }else if (section == 1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 6)];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 6)];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }
    
    
}
@end
