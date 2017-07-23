//
//  PlanListDataProvider.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "PlanListDataProvider.h"
#import "ScheduleCell.h"
@implementation PlanListDataProvider

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// セル数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// セルの内容を設定
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // カスタムセルを取得
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleCell" forIndexPath:indexPath];
    
    
    cell.timeLb.text = @"aaaaa";
    
    return cell;
}



@end
