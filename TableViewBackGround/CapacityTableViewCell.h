//
//  CapacityTableViewCell.h
//  TableViewBackGround
//
//  Created by sujian on 16/5/5.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapacityTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *fieldValue;
@property (nonatomic, assign) CGFloat progress;
@end
