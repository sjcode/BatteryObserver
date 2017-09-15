//
//  CapacityTableViewCell.m
//  TableViewBackGround
//
//  Created by sujian on 16/5/5.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import "CapacityTableViewCell.h"

@interface CapacityTableViewCell()
@property (nonatomic, weak) IBOutlet YLProgressBar *progressBar;
@end

@implementation CapacityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.progressBar.type = YLProgressBarTypeFlat;
    self.progressBar.backgroundColor = RGBA(217, 56, 41,0.5);
    self.progressBar.progressTintColors  = @[RGBA(217, 56, 41, 1)];
    self.progressBar.hideStripes        = YES;
    
    self.progressBar.hideTrack = YES;
    self.progressBar.hideGloss = YES;
    self.progressBar.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeProgress;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProgress:(CGFloat)progress{
    if (progress>0 && progress!=NAN) {
        [self.progressBar setProgress:progress animated:YES];
    }
}

@end
