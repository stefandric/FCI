//
//  LogicHelper.m
//  FCI
//
//  Created by Stefan Andric on 10/5/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import "LogicHelper.h"

@implementation LogicHelper

+ (BOOL)isNull:(id)check
{
    if (check != (id)[NSNull null]) {
        return NO;
    }
    
    return YES;
}

+ (NSDate *)getDateFromString:(NSString *)stringDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *date = [dateFormat dateFromString:stringDate];
    
    return date;
}

@end
