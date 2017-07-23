//
//  PlanListViewController.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "PlanListViewController.h"
#import "PlanListDataProvider.h"

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
    
    [self setTimeLine];
    
}

-(void)setTimeLine{

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self.selectedDate];
    
    components.hour = 00;
    components.minute = 00;
    
    NSDate *timeLineComp = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSDate *timeComp;
    self.provider.timeArray = [[NSMutableArray alloc]init];
    [self.provider.timeArray addObject:timeLineComp];
    
    for(int i=0;i<47;i++){
        
        timeComp = [timeLineComp initWithTimeInterval:30*60 sinceDate:timeLineComp];
        timeLineComp = timeComp;
        [self.provider.timeArray addObject:timeComp];
    }
    [self.scheduleTableView reloadData];
}



@end
