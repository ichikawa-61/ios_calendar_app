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
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
   
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
