//
//  PlanListViewController.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "PlanListViewController.h"
#import "PlanSettingViewController.h"
#import "PlanListDataProvider.h"
#import "TimeLogic.h"

@interface PlanListViewController ()<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *scheduleTableView;
@property (nonatomic) PlanListDataProvider *provider;
@end

@implementation PlanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"ScheduleCell" bundle:nil];
    [self.scheduleTableView registerNib:nib forCellReuseIdentifier:@"ScheduleCell"];
    
    self.provider = [[PlanListDataProvider alloc]init];
    self.scheduleTableView.delegate = self;
    self.scheduleTableView.dataSource = self.provider;
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    TimeLogic *logic = [[TimeLogic alloc]init];
    self.provider.timeArray = [[NSMutableArray alloc]init];
    NSDate *theDate = self.selectedDate;
    NSMutableArray *array =  [[NSMutableArray alloc]init];
    array = [logic setTimeLine:(NSDate*)theDate];
    self.provider.timeArray = array;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.scheduleTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PlanSetting" bundle:[NSBundle mainBundle]];
    
    PlanSettingViewController *thirdVC = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:thirdVC animated:true];


}


@end
