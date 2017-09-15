//
//  NormalTableViewCell.m
//  TableViewBackGround
//
//  Created by sujian on 16/5/5.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import "NormalTableViewCell.h"
@interface NormalTableViewCell()

@end


@implementation NormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValueColor:(UIColor *)valueColor{
    [self.fieldValue setTextColor:valueColor];
}

@end
