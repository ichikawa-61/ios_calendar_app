//
//  PlanDataProvider.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "PlanDataProvider.h"
#import "PlanCell.h"
#import "DetailCell.h"
#import "TimeCell.h"

@interface PlanDataProvider()<UITextFieldDelegate>
@property (nonatomic) UITextField *textfield;
@end

@implementation PlanDataProvider

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.plan = [[Plan alloc]init];
    return NUMBER_OF_SECTION;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case TITLE_PLACE_SECTION:{
            
            return 2;
        }
        case START_END_SECTION:{
            
            return 2;
        }
        case DETAIL_SECTION:{
            
            return 1;
        }
    }return 2;    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   switch (indexPath.section) {
    case TITLE_PLACE_SECTION:
        switch (indexPath.row) {
            case TITLE:{
                PlanCell *cellType1 = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
                cellType1.textField.placeholder = @"タイトル(必須)";
                cellType1.textField.tag = 1;
                cellType1.textField.delegate = self;
                return cellType1;
            }
            case PLACE:{
                PlanCell *cellType1 = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
                cellType1.textField.placeholder = @"場所";
                cellType1.textField.tag = 2;
                cellType1.textField.delegate = self;
                return cellType1;
            }
        }break;
    case START_END_SECTION:
        switch (indexPath.row) {
            case START_TIME:{
                TimeCell *cellType3 = [tableView dequeueReusableCellWithIdentifier:@"TimeCell" forIndexPath:indexPath];
                NSDateFormatter *formatter = [NSDateFormatter new];
                formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
                formatter.dateFormat = @"YYYY/MM/dd HH:mm~";
                NSString *stringDate = [formatter stringFromDate:self.chosenDate];
                
                cellType3.startTimeLb.text = stringDate;
                return cellType3;
            }
            case END_TIME:{
                PlanCell *cellType1 = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
                cellType1.textField.placeholder = @"終了時間(必須)";
                cellType1.textField.tag = 3;
                cellType1.textField.delegate = self;            }
        }break;
     case DETAIL_SECTION:
        switch (indexPath.row) {
            case START_TIME:{
                DetailCell *cellType5 = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
                return cellType5;
            }
        }break;

    }UITableViewCell *cell = [UITableViewCell new];
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField
{
    NSInteger textfieldTag = textField.tag;
    if (textfieldTag == 3){
        
        self.textfield = [[UITextField alloc]init];
        self.textfield = textField;
        if ([self.delegate respondsToSelector:@selector(startEditingTextfield)])
        {
            [textField resignFirstResponder];
             [self.delegate startEditingTextfield];
        }
        return NO;
    }else if(textfieldTag == 1){
        self.plan.planTitle = textField.text;
    }else if(textfieldTag == 2){
        self.plan.place = textField.text;
    }else{
        self.plan.strEndTime = textField.text;
    }
    self.plan.startTime = self.chosenDate;
    return YES;

    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];

    return YES;
}

-(void)setEndTime:(NSDate*)endDate{

    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy/MM/dd HH:mm~ ";
    NSString *strDate = [df stringFromDate:endDate];

    self.textfield.text = strDate;
}





@end
