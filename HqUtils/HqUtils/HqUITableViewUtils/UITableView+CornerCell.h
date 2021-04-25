//
//  UITableView+CornerCell.h
//  HqUtils
//
//  Created by hehuiqi on 2021/4/25.
//  Copyright © 2021 hhq. All rights reserved.
//

/**
 Example:
 //UITableViewDelegate
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView tableViewCell:cell corneRadius:10 marginSpace:15 forRowAtIndexPath:indexPath];
 }
 
 */

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (CornerCell)

@property(nonatomic,assign) BOOL cellShowShadow;


- (void)tableViewCell:(UITableViewCell *)cell corneRadius:(CGFloat)corneRadius marginSpace:(CGFloat)marginSpace forRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
