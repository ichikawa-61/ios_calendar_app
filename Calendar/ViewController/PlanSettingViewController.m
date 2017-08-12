//
//  PlanSettingViewController.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "PlanSettingViewController.h"
//View
#import "PlanCell.h"
#import "PlanDataProvider.h"
//Model
#import "ScheduleManager.h"
#import "Plan.h"


@interface PlanSettingViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (nonatomic) PlanDataProvider *itemProvider;
- (IBAction)tapResisterButton:(id)sender;

@end

@implementation PlanSettingViewController

- (void)viewDidLoad {
    
    UINib *nib = [UINib nibWithNibName:@"PlanCell" bundle:nil];
    [self.settingTableView registerNib:nib forCellReuseIdentifier:@"PlanCell"];
    UINib *nib2 = [UINib nibWithNibName:@"TimeCell" bundle:nil];
    [self.settingTableView registerNib:nib2 forCellReuseIdentifier:@"TimeCell"];
    UINib *nib3 = [UINib nibWithNibName:@"DetailCell" bundle:nil];
    [self.settingTableView registerNib:nib3 forCellReuseIdentifier:@"DetailCell"];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"登録"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(tapAddButton)];
    self.navigationItem.rightBarButtonItems = @[addButton];

    self.itemProvider = [[PlanDataProvider alloc]init];
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self.itemProvider;

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY/MM/dd";
    NSString *navTitle = [formatter stringFromDate: self.selectedHour.aDate];
    self.navigationController.title = [NSString stringWithFormat:@"%@",navTitle];
    
    NSDate *date = self.selectedHour.aDate;
    self.itemProvider.chosenDate = date;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView.sectionHeaderHeight;
}

-(void)checkText{

    
}

-(void)tapAddButton{

    ScheduleManager *manager = [[ScheduleManager alloc]init];
    Plan *plan = [[Plan alloc]init];
    
    [self checkText];
}

- (IBAction)tapResisterButton:(id)sender {
    
    
}
@end
