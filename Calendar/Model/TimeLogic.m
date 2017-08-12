//
//  TimeLogic.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "TimeLogic.h"

@implementation TimeLogic

-(NSMutableArray<NSDate *>*)setTimeLine:(CalendarLogic*)selectedDate{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:selectedDate.aDate];
    
    components.hour = 00;
    components.minute = 00;
    
    NSDate *timeLineComp = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSDate *timeComp;
    NSMutableArray *timeList = [[NSMutableArray alloc]init];
    [timeList addObject:timeLineComp];
    
    for(int i=0;i<47;i++){
        
        timeComp = [timeLineComp initWithTimeInterval:30*60 sinceDate:timeLineComp];
        timeLineComp = timeComp;
        [timeList addObject:timeComp];
    }
        
    return timeList;
}


@end
