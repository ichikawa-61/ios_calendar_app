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

@implementation PlanDataProvider

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

   return @"de";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
        
    switch (indexPath.section) {
        case TITLE_PLACE_SECTION:
            switch (indexPath.row) {
                
                case TITLE:{
                     PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
                    cell.textField.placeholder = @"タイトル";
                    return cell;
                }
                case PLACE:{
                     PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
                    
                    cell.textField.placeholder = @"場所";
                }
            }break;
        case START_END_SECTION:
            switch (indexPath.row) {
                case START_TIME:{
                    TimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell" forIndexPath:indexPath];
                    NSDateFormatter *formatter = [NSDateFormatter new];
                    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
                    formatter.dateFormat = @"YYYY/MM/dd HH:mm~";
                    NSString *stringDate = [formatter stringFromDate:self.chosenDate];
                    
                    cell.startTimeLb.text = stringDate;
                    return cell;
                }
                case END_TIME:{
                     TimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell" forIndexPath:indexPath];
                    return cell;
                }
            }break;
         case DETAIL_SECTION:
            switch (indexPath.row) {
                case START_TIME:{
                    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
                    return cell;
                }
            }break;
    }return cell;

}



@end
