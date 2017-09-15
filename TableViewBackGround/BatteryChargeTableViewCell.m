//
//  BatteryChargeTableViewCell.m
//  TableViewBackGround
//
//  Created by sujian on 16/5/5.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import "BatteryChargeTableViewCell.h"

@interface BatteryChargeTableViewCell()
@property (nonatomic, weak) IBOutlet YLProgressBar *progressBar;
@end

@implementation BatteryChargeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.progressBar.type = YLProgressBarTypeFlat;
    self.progressBar.backgroundColor = RGBA(152, 190, 0,0.5);
    self.progressBar.progressTintColors  = @[RGBA(152, 190, 0, 1)];
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
