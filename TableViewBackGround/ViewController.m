//
//  ViewController.m
//  TableViewBackGround
//
//  Created by sujian on 16/5/5.
//  Copyright © 2016年 sujian. All rights reserved.
//

#import "ViewController.h"
#import "BatteryChargeTableViewCell.h"
#import "CapacityTableViewCell.h"
#import "NormalTableViewCell.h"
#import "UIDeviceListener.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,weak) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) BatteryChargeTableViewCell *batteryChargeCell;
@property (nonatomic ,strong) CapacityTableViewCell *capacityCell;
@property (nonatomic, strong) UIDeviceListener *listener;

@property (nonatomic, assign) CGFloat maxCapacity;
@property (nonatomic, assign) CGFloat designCapacity;
@property (nonatomic, assign) CGFloat currentCapacity;
@property (nonatomic, assign) NSInteger cycleCount;
@property (nonatomic, assign) NSInteger voltage;
@property (nonatomic, assign) NSInteger temperature;
@property (nonatomic, assign) NSInteger discharge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BatteryChargeTableViewCell" bundle:nil] forCellReuseIdentifier:@"BatteryChargeTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CapacityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CapacityTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NormalTableViewCell" bundle:nil] forCellReuseIdentifier:@"NormalTableViewCell"];

    self.tableView.tableFooterView = [[UIView alloc]init];
    [UIDevice currentDevice].batteryMonitoringEnabled = NO;
    self.listener = [UIDeviceListener sharedUIDeviceListener];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenerDataUpdated:) name: kUIDeviceListenerNewDataNotification object:nil];
    
    //[listener startListener];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenerDataUpdated:) name: kUIDeviceListenerNewDataNotification object:nil];
    
    [self.listener startListener];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"TAP ON THE READING TO GET MORE INFORMATION.";
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BatteryChargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BatteryChargeTableViewCell" forIndexPath:indexPath];
            cell.fieldValue.text = [NSString stringWithFormat:@"%d/%d mAh",(int)self.currentCapacity, (int)self.maxCapacity];
            CGFloat scale = (CGFloat)self.currentCapacity / (CGFloat)self.maxCapacity;
            [cell setProgress:scale];
            return cell;
        }else if(indexPath.row == 1){
            CapacityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CapacityTableViewCell" forIndexPath:indexPath];
            cell.fieldValue.text = [NSString stringWithFormat:@"%d/%d mAh",(int)self.maxCapacity,(int)self.designCapacity];
            CGFloat scale = (CGFloat)self.maxCapacity / (CGFloat)self.designCapacity;
            [cell setProgress:scale];
            return cell;
        }else if(indexPath.row == 2){
            NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalTableViewCell" forIndexPath:indexPath];
            cell.fieldName.text = @"Voltage";
            cell.fieldValue.text = [NSString stringWithFormat:@"%0.2f V",(CGFloat)self.voltage / (CGFloat)1000];
            return cell;
        }else if(indexPath.row == 3){
            NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalTableViewCell" forIndexPath:indexPath];
            cell.fieldName.text = @"Cycles";
            cell.fieldValue.text = [NSString stringWithFormat:@"%d",(int)self.cycleCount];
            return cell;
        }else if(indexPath.row == 4){
            NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalTableViewCell" forIndexPath:indexPath];
            cell.fieldName.text = @"Temperature";
            cell.fieldValue.text = [NSString stringWithFormat:@"%0.2f ℃",((CGFloat)self.temperature)/100];
            cell.valueColor = UIColor.greenColor;
            return cell;
        }else if(indexPath.row == 5){
            NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalTableViewCell" forIndexPath:indexPath];
            cell.fieldName.text = @"Discharge Current";
            cell.fieldValue.text = [NSString stringWithFormat:@"%d mA",(int)self.discharge*-1];
            cell.valueColor = UIColor.redColor;
            
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BatteryChargeTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 71;
    }else{
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.font = [UIFont systemFontOfSize:10];
    myLabel.numberOfLines = 0;
    NSString *headerTitle = [self tableView:tableView titleForHeaderInSection:section];
    myLabel.text = headerTitle;
    CGSize  size = [headerTitle sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(240, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat x = 8;
    CGFloat y = 50 / 2 - size.height / 2 +10;
    myLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [headerView addSubview:myLabel];
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (void) listenerDataUpdated: (NSNotification *) notification{
    NSString *message = [notification.userInfo description];
    NSDictionary *dict = [message propertyList];
    if (dict) {
        
        self.maxCapacity = [(NSNumber*)dict[@"MaxCapacity"] floatValue];
        
        self.currentCapacity = [(NSNumber*)dict[@"CurrentCapacity"]floatValue];
        self.designCapacity = [(NSNumber*)dict[@"DesignCapacity"] floatValue];
        self.cycleCount = [(NSNumber*)dict[@"CycleCount"]integerValue];
        self.voltage = [(NSNumber*)dict[@"Voltage"]integerValue];
        self.temperature = [(NSNumber*)dict[@"Temperature"]integerValue];
        self.discharge = [(NSNumber*)dict[@"InstantAmperage"]integerValue];
        NSLog(@"%f",self.currentCapacity);
        
        [self.tableView reloadData];
    }
}
@end
