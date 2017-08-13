//
//  PlanSettingViewController.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "PlanSettingViewController.h"
#import "StringDefinition.h"
//View
#import "DayCell.h"
#import "DayCell.h"
#import "PlanDataProvider.h"
//Model
#import "ScheduleManager.h"
#import "Plan.h"
#import "AlertController.h"



@interface PlanSettingViewController ()<UITableViewDelegate,PlanDataProviderDelegate>
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (nonatomic) PlanDataProvider *itemProvider;
@property (nonatomic,strong) UIDatePicker *dp;
@property (nonatomic,strong) Plan *plan;
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
    
    self.dp = [[UIDatePicker alloc]init];
    
    CGSize boundsSize = self.view.bounds.size;
    self.dp.center = CGPointMake( boundsSize.width / 2, boundsSize.height /1.2 );
    self.dp.minuteInterval = 30;
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss +0900";
    
    //選択できるの日付・時刻の範囲を指定
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self.selectedHour.aDate];
    
    components.hour = 23;
    components.minute = 30;

    NSDate *maxDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    self.dp.minimumDate = self.selectedHour.aDate;
    self.dp.maximumDate = maxDate;
    [self.dp addTarget:self
                action:@selector(changeDate)
      forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.dp];
 
    self.dp.hidden = YES;
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"登録"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(tapAddButton)];
    self.navigationItem.rightBarButtonItems = @[addButton];

    self.itemProvider = [[PlanDataProvider alloc]init];
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self.itemProvider;
    self.itemProvider.delegate = self;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"YYYY/MM/dd";
    NSString *strDate = [formatter stringFromDate: self.selectedHour.aDate];
    self.navigationItem.title = [NSString stringWithFormat:@"%@",strDate];
    
    NSDate *date = self.selectedHour.aDate;
    self.itemProvider.chosenDate = date;
    
    
    }

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == DETAIL_SECTION){
        return 200;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == START_END_SECTION){
        return 50;
    }
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(!( section == DETAIL_SECTION)){
        return 0;
    }
    return 200 ;
}

-(void)startEditingTextfield{
    
    [self customizeDatePickerView];
    self.dp.hidden = NO;
}

-(void)tapAddButton{
    
    //ScheduleManager *manager = [[ScheduleManager alloc]init];
    self.plan = [[Plan alloc]init];
    self.plan = self.itemProvider.plan;
    
    [self checkText];
}

-(void)changeDate{


}

//Validation check
-(void)checkText{
    
    if([self.plan.planTitle length] == 0 && [self.plan.strEndTime length] == 0){
    
        [AlertController validateText:self
                          titleString:TitleEndTimeEmpty
                        messageString:@""
                           actionFunc:^(UIAlertAction *alertAction){
                               return;
                           }
         ];
    }
    
    if([self.plan.planTitle length] == 0){
        
        [AlertController validateText:self
                          titleString:TitleEmpty
                        messageString:@""
                           actionFunc:^(UIAlertAction *alertAction){
                               return;
                           }
        ];
    }
    
    if([self.plan.strEndTime length] == 0){
        
        [AlertController validateText:self
                          titleString:EndTimeEmpty
                        messageString:@""
                           actionFunc:^(UIAlertAction *alertAction){
                               return;
                           }
         ];
    }

}

-(void)customizeDatePickerView{

//self.datePickerView.datePicker.minuteInterval = 30;
}

- (IBAction)tapResisterButton:(id)sender {
    
    
}
@end
