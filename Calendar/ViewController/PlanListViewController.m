//
//  PlanListViewController.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//
//ViewController
#import "PlanListViewController.h"
#import "PlanSettingViewController.h"
//View
#import "PlanListDataProvider.h"
//Model
#import "TimeLogic.h"
#import "ScheduleManager.h"
#import "Plan.h"

@interface PlanListViewController ()<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *scheduleTableView;
@property (nonatomic) PlanListDataProvider *provider;
@property (nonatomic) TimeLogic *logic;
@property (strong, nonatomic) Plan *plan;

@end

@implementation PlanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"ScheduleCell" bundle:nil];
    [self.scheduleTableView registerNib:nib forCellReuseIdentifier:@"ScheduleCell"];
    
    self.provider = [[PlanListDataProvider alloc]init];
    self.scheduleTableView.delegate = self;
    self.scheduleTableView.dataSource = self.provider;
    
    self.logic = [[TimeLogic alloc]init];
    self.provider.timeArray = [[NSMutableArray alloc]init];
    
    NSMutableArray *array =  [[NSMutableArray alloc]init];
    array = [self.logic setTimeLine:self.selectedDate];
    self.provider.timeArray = array;
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"<戻る"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(tapGoBackButton)];
    self.navigationItem.leftBarButtonItems = @[addButton];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];

    formatter.dateFormat = @"YYYY年MM月dd日 E曜日";
    NSString *strDate = [formatter stringFromDate: self.selectedDate.aDate];
    self.navigationItem.title = [NSString stringWithFormat:@"%@",strDate];
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.scheduleTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PlanSetting" bundle:[NSBundle mainBundle]];
    PlanSettingViewController *thirdVC = [storyboard instantiateInitialViewController];
    //thirdVC.selectedHour.aDate =
    
    thirdVC.selectedHour = [[CalendarLogic alloc]init];
    thirdVC.selectedHour.aDate = [self.provider.timeArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:thirdVC animated:true];


}

-(void)tapGoBackButton{

    [self.navigationController popViewControllerAnimated:YES];
}


@end
