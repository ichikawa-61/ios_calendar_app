//
//  ScheduleManager.m
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "ScheduleManager.h"
#import "FMDB.h"
#import "Plan.h"

@interface ScheduleManager ()

@property(nonatomic,copy) NSString* db_path;
@end

@implementation ScheduleManager

-(id)init{
    
    self = [super init];
    if(self){
        FMDatabase* db = [self getConnection];
        [db open];
        NSString *sql = @"CREATE TABLE IF NOT EXISTS  t_plan(plan_id INTEGER PRIMARY KEY AUTOINCREMENT, plan_title TEXT, place TEXT, start_date DATE, end_date DATE, detail TEXT); ";
        [db executeUpdate:sql];
        [db close];
    }
    return self;
}

+(NSString*)getDbFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSLog(@"%@",paths);
    NSString *dir = [paths
                     objectAtIndex:0];
    return [dir stringByAppendingPathComponent:@"plan.db"];
}

-(void)addNewMemo:(Plan*)plan{
    
    NSString *title      = plan.planTitle;
    NSDate *startDate    = plan.startTime;
    NSDate *endDate      = plan.endTime;
    NSString *place      = plan.place;
    NSString *detail     = plan.detail;
    
    FMDatabase* db = [self getConnection];
    [db open];
    [db beginTransaction];
    
    NSString *sql = @"INSERT INTO t_plan (plan_title, start_time, end_time, place, detail) VALUES (?,?,?,?,?)";
    
    BOOL t = [db executeUpdate:sql,title,startDate,endDate,place,detail];
    NSLog(@"%d",t);
    
    [db commit];
    [db close];
    
}

-(NSMutableArray<Plan*>*)showMemoList:(NSInteger)planId{
    
    FMDatabase *db = [self getConnection];
    NSString *sqlite = @"SELECT* FROM t_plan WHERE plan_id = ?";
    [db open];
    FMResultSet* results = [db executeQuery:sqlite,planId];
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:0];
    while ([results next]){
        Plan* plan = [[Plan alloc] init];
        
        plan.planId       = [results intForColumn:@"plan_id"];
        plan.planTitle    = [results stringForColumn:@"plan_title"];
        plan.startTime    = [results dateForColumn:@"start_time"];
        plan.startTime    = [results dateForColumn:@"end_time"];
        plan.place        = [results stringForColumn:@"place"];
        plan.detail       = [results stringForColumn:@"detail"];
        
        [list addObject:plan];
    }
    [db close];
    return list;
    
}


-(FMDatabase*)getConnection{
    if(self.db_path == nil){
        self.db_path = [ScheduleManager getDbFilePath];
    }
    
    return [FMDatabase databaseWithPath:self.db_path];
};


@end