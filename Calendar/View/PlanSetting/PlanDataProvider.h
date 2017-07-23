//
//  PlanDataProvider.h
//  Calendar
//
//  Created by Manami Ichikawa on 7/23/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PlanDataProvider : NSObject<UITableViewDataSource>

@property (nonatomic) NSDate *chosenDate;
typedef NS_ENUM(NSInteger, PlanDataProviderSection) {
    
    TITLE_PLACE_SECTION,
    START_END_SECTION,
    DETAIL_SECTION,
    NUMBER_OF_SECTION
    
};

typedef NS_ENUM(NSInteger, PlanDataProviderRow) {
    
    TITLE = 0,
    PLACE = 1,
    START_TIME = 0,
    END_TIME = 1,
    DETAIL = 0
    
};

@end