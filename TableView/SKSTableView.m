//
//  SKSTableView.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableView.h"
#import "SKSTableViewCell.h"

#import "JFDealWaySubCell.h"
#import <objc/runtime.h>

#pragma mark - NSArray (SKSTableView)

@interface NSMutableArray (SKSTableView)

- (void)initiateObjectsForCapacity:(NSInteger)numItems;

@end

@implementation NSMutableArray (SKSTableView)

- (void)initiateObjectsForCapacity:(NSInteger)numItems
{
    for (NSInteger index = [self count]; index < numItems; index++) {
        NSMutableArray *array = [NSMutableArray array];
        [self addObject:array];
    }
}

@end

#pragma mark - SKSTableView


@interface SKSTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *expandedIndexPaths;

@property (nonatomic, strong) NSMutableDictionary *expandableCells;

@property (nonatomic,strong)NSIndexPath* selectedIndexPath;

//@property (nonatomic,strong)UIImageView *selectedIndicatorImg;
@end

@implementation SKSTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
    }
    
    return self;
}

- (void)setSKSTableViewDelegate:(id<SKSTableViewDelegate>)SKSTableViewDelegate
{
    self.dataSource = self;
    self.delegate = self;
    
    [self setSeparatorColor:[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]];
    
    if (SKSTableViewDelegate)
        _SKSTableViewDelegate = SKSTableViewDelegate;
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    [super setSeparatorColor:separatorColor];
   
}
//- (UIImageView*)selectedIndicatorImg{
//    if (!_selectedIndicatorImg) {
//        _selectedIndicatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 16)];
//        [_selectedIndicatorImg setImage:[UIImage imageNamed:@"pruchase_CellSelected_LeftIndicator"]];
//        [_selectedIndicatorImg setCenter:CGPointMake(17/2, self.bounds.size.height/2)];
//        
//    }
//    return _selectedIndicatorImg;
//}
- (NSMutableArray *)expandedIndexPaths
{
    if (!_expandedIndexPaths)
        _expandedIndexPaths = [NSMutableArray array];
    
    return _expandedIndexPaths;
}

- (NSMutableDictionary *)expandableCells
{
    if (!_expandableCells)
        _expandableCells = [NSMutableDictionary dictionary];
    
    return _expandableCells;
}

#pragma mark - UITableViewDataSource

#pragma mark - Required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger otherCount = [[[self expandedIndexPaths] objectAtIndex:section] count];
    
    NSInteger  count =[_SKSTableViewDelegate tableView:tableView numberOfRowsInSection:section]+otherCount;
    
    return  count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (![self.expandedIndexPaths[indexPath.section] containsObject:indexPath]) {
        
        NSIndexPath *tempIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
        SKSTableViewCell *cell = (SKSTableViewCell *)[_SKSTableViewDelegate tableView:tableView cellForRowAtIndexPath:tempIndexPath];
        
        if ([[self.expandableCells allKeys] containsObject:tempIndexPath])
            [cell setIsExpanded:[[self.expandableCells objectForKey:tempIndexPath] boolValue]];

        [cell setSeparatorInset:UIEdgeInsetsZero];
        
        if (cell.isExpandable) {
            
            [self.expandableCells setObject:[NSNumber numberWithBool:[cell isExpanded]]
                                     forKey:indexPath];
            
            UIButton *expandableButton = (UIButton *)cell.accessoryView;
            [expandableButton addTarget:tableView
                                 action:@selector(expandableButtonTouched:event:)
                       forControlEvents:UIControlEventTouchUpInside];
            
            if (cell.isExpanded) {
                
                cell.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
                
            } else {
                //可展开但是 未展开 的cell
//                if ([cell containsIndicatorView])
//                    [cell removeIndicatorView];
                
            }
            
        } else {
            // 不可以展开的cell
            if (cell.indexPath.section == 0 && cell.indexPath.row == 0) {
                cell.accessoryView = nil;
             }
           
            //[cell removeIndicatorView];
         
            
        }
       [cell setUserSelected:NO];
        if (cell.indexPath.section == 0&& cell.indexPath.row ==0) {
            // 调整第一个视图
        }
        return cell;
        
    } else {
        // subCell
       
        JFDealWayCell *cell = (JFDealWayCell*)[_SKSTableViewDelegate tableView:(SKSTableView *)tableView cellForSubRowAtIndexPath:indexPath];
        
        cell.backgroundColor = [self separatorColor];
        cell.indentationLevel = 0;
        
        [cell setUserSelected:NO];
        return cell;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 200;
    }else if(indexPath.row == 0 && indexPath.section != 0){
        return 63;
    }else
        
        return 44;
}

#pragma mark - Optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_SKSTableViewDelegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        
        NSInteger numberOfSections = [_SKSTableViewDelegate numberOfSectionsInTableView:tableView];
        
        if ([self.expandedIndexPaths count] != numberOfSections)
            [self.expandedIndexPaths initiateObjectsForCapacity:numberOfSections];
        
        return numberOfSections;
        
    }
    
    return 1;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   return  [_SKSTableViewDelegate tableView:tableView viewForFooterInSection:section];
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    NSInteger count =  [_SKSTableViewDelegate numberOfSectionsInTableView:tableView];
    if (section == count -1) {
        return 106;
    }
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}


#pragma mark 调整radio button的状态
- (void)adjustRadioStatusByIndexPath:(NSIndexPath*)sindexPath  tableView:(UITableView*)tableView LastIndexPath:(NSIndexPath*)indexPath{
    JFDealWayCell * willSelectdCell = [tableView cellForRowAtIndexPath:sindexPath];
    JFDealWayCell *lastCell = [tableView cellForRowAtIndexPath:indexPath]
    ;
    if (willSelectdCell.accessoryView && [willSelectdCell.accessoryView isKindOfClass:[JFDealWayRadioButton class]]) {
        if(self.selectedIndexPath){
        
         [lastCell.radioButton setSelected:NO];
            
        }
        [lastCell setUserSelected:NO];
        [willSelectdCell setUserSelected:YES];
        
        self.selectedIndexPath = sindexPath;
        
    }

}
#pragma mark - UITableViewDelegate

#pragma mark - Optional

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSIndexPath * templastPath = self.selectedIndexPath;
    
    __block JFDealWayCell *cell = (JFDealWayCell *)[tableView cellForRowAtIndexPath:indexPath];
   
    // 过滤出可点击的radio Cell
    
    [self adjustRadioStatusByIndexPath:indexPath tableView:tableView LastIndexPath:self.selectedIndexPath];
    
    if ([cell isKindOfClass:[SKSTableViewCell class]] && cell.isExpandable) {
//        if (self.selectedIndexPath != indexPath ) {
//            NSIndexPath * changedIndexPath = [NSIndexPath indexPathForRow:0 inSection:templastPath.section];
//            __block JFDealWayCell *lastCell = (JFDealWayCell *)[tableView cellForRowAtIndexPath:changedIndexPath];
//            if ([lastCell isKindOfClass:[SKSTableViewCell class]]&& cell.isExpandable ) {
//                [self drawupTableView:tableView indexPath:self.selectedIndexPath];
//            }
//        
//        }
         [self drawupTableView:tableView indexPath:indexPath];
        
    }else{
        // subcell
       
        
        
    }

}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([_SKSTableViewDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)])
        [_SKSTableViewDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}


#pragma mark support  menthods
// 收起
- (void)drawupTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
   
    __block JFDealWayCell *cell = (JFDealWayCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.isExpanded = !cell.isExpanded;
    
    
    NSInteger numberOfSubRows = [self numberOfSubRowsAtIndexPath:indexPath];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    for (NSInteger index = 1; index <= numberOfSubRows; index++) {
        
        NSIndexPath *expIndexPath = [NSIndexPath indexPathForRow:row+index inSection:section];
        [indexPaths addObject:expIndexPath];
    }
    
    if (cell.isExpanded) {
        
        [self setIsExpanded:YES forCellAtIndexPath:indexPath];
        [self insertExpandedIndexPaths:indexPaths forSection:indexPath.section];
        [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        JFDealWayCell *changeStatusCell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
       
        [changeStatusCell setUserSelected:YES];
        
    } else {
        
            [self setIsExpanded:NO forCellAtIndexPath:indexPath];
            [self removeExpandedIndexPaths:indexPaths forSection:indexPath.section];
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        
       
        
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        if (cell.isExpanded) {
            
            cell.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
            
        } else {
            cell.accessoryView.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finished) {
        
        //            if (!cell.isExpanded)
        //                [cell removeIndicatorView];
        
    }];

}


#pragma mark - SKSTableViewUtils

- (IBAction)expandableButtonTouched:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self];
    
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:currentTouchPosition];
    
    if (indexPath)
        [self tableView:self accessoryButtonTappedForRowWithIndexPath:indexPath];
}

- (NSInteger)numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [_SKSTableViewDelegate tableView:self numberOfSubRowsAtIndexPath:[self correspondingIndexPathForRowAtIndexPath:indexPath]];
}

- (NSIndexPath *)correspondingIndexPathForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = 0;
    NSInteger row = 0;
    
    while (index < indexPath.row) {
        
        NSIndexPath *tempIndexPath = [self correspondingIndexPathForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:indexPath.section]];
        BOOL isExpanded = [[self.expandableCells allKeys] containsObject:tempIndexPath] ? [[self.expandableCells objectForKey:tempIndexPath] boolValue] : NO;
        
        if (isExpanded) {
            
            NSInteger numberOfExpandedRows = [_SKSTableViewDelegate tableView:self numberOfSubRowsAtIndexPath:tempIndexPath];
            
            index += (numberOfExpandedRows + 1);
            
        } else
            index++;
        
        row++;
        
    }
    
    return [NSIndexPath indexPathForRow:row inSection:indexPath.section];
}


- (void)setIsExpanded:(BOOL)isExpanded forCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *correspondingIndexPath = [self correspondingIndexPathForRowAtIndexPath:indexPath];
    [self.expandableCells setObject:[NSNumber numberWithBool:isExpanded] forKey:correspondingIndexPath];
}

- (void)insertExpandedIndexPaths:(NSArray *)indexPaths forSection:(NSInteger)section
{
    NSIndexPath *firstIndexPathToExpand = indexPaths[0];
    NSIndexPath *firstIndexPathExpanded = nil;
    
    if ([self.expandedIndexPaths[section] count] > 0) firstIndexPathExpanded = self.expandedIndexPaths[section][0];
    
    __block NSMutableArray *array = [NSMutableArray array];
    
    if (firstIndexPathExpanded && firstIndexPathToExpand.section == firstIndexPathExpanded.section && firstIndexPathToExpand.row < firstIndexPathExpanded.row) {
        
        [self.expandedIndexPaths[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSIndexPath *updated = [NSIndexPath indexPathForRow:([obj row] + [indexPaths count])
                                                      inSection:[obj section]];
            
            [array addObject:updated];
        }];
        
        [array addObjectsFromArray:indexPaths];
        
        self.expandedIndexPaths[section] = array;
        
    } else {
        
        [self.expandedIndexPaths[section] addObjectsFromArray:indexPaths];
        
    }
    
    //[self sortExpandedIndexPathsForSection:section];
}


- (void)removeExpandedIndexPaths:(NSArray *)indexPaths forSection:(NSInteger)section
{
    NSUInteger index = [self.expandedIndexPaths[section] indexOfObject:indexPaths[0]];
    
    [self.expandedIndexPaths[section] removeObjectsInArray:indexPaths];
    
    if (index == 0) {
        
        __block NSMutableArray *array = [NSMutableArray array];
        [self.expandedIndexPaths[section] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSIndexPath *updated = [NSIndexPath indexPathForRow:([obj row] - [indexPaths count])
                                                      inSection:[obj section]];
            
            [array addObject:updated];
        }];
        
        self.expandedIndexPaths[section] = array;
        
    }
    
    [self sortExpandedIndexPathsForSection:section];
}

- (void)sortExpandedIndexPathsForSection:(NSInteger)section
{
    [self.expandedIndexPaths[section] sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 section] < [obj2 section])
            return (NSComparisonResult)NSOrderedAscending;
        else if ([obj1 section] > [obj2 section])
            return (NSComparisonResult)NSOrderedDescending;
        else {
            
            if ([obj1 row] < [obj2 row])
                return (NSComparisonResult)NSOrderedAscending;
            else
                return (NSComparisonResult)NSOrderedDescending;
            
        }
    }];
}

@end

#pragma mark - NSIndexPath (SKSTableView)

static void *SubRowObjectKey;

@implementation NSIndexPath (SKSTableView)

@dynamic subRow;

- (NSInteger)subRow
{
    id subRowObj = objc_getAssociatedObject(self, SubRowObjectKey);
    return [subRowObj integerValue];
}

- (void)setSubRow:(NSInteger)subRow
{
    id subRowObj = [NSNumber numberWithInteger:subRow];
    objc_setAssociatedObject(self, SubRowObjectKey, subRowObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSIndexPath *)indexPathForSubRow:(NSInteger)subrow inRow:(NSInteger)row inSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    indexPath.subRow = subrow;
    
    return indexPath;
}

@end

