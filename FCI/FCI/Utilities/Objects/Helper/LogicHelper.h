//
//  LogicHelper.h
//  FCI
//
//  Created by Stefan Andric on 10/5/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogicHelper : NSObject
+ (BOOL)isNull:(id)check;
+ (NSDate *)getDateFromString:(NSString *)stringDate;
@end
