//
//  AnnotationObject.m
//  FCI
//
//  Created by Stefan Andric on 10/5/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import "AnnotationObject.h"
#import "LogicHelper.h"

@implementation AnnotationObject

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        NSDictionary *location = [dict objectForKey:@"location"];
        
        
        if ([LogicHelper isNull:[location objectForKey:@"lat"]] == NO) {
            self.latitude = [[location objectForKey:@"lat"] floatValue];
        }
        else {
            self.latitude = 0;
        }
        
        if ([LogicHelper isNull:[location objectForKey:@"lng"]] == NO) {
            self.longitude = [[location objectForKey:@"lng"] floatValue];
        }
        else {
            self.longitude = 0;
        }
        
        if ([LogicHelper isNull:[dict objectForKey:@"id"]] == NO) {
            self.idAnnotation = [[dict objectForKey:@"id"] integerValue];
        }
        else {
            self.idAnnotation = 0;
        }
        
        if ([LogicHelper isNull:[dict objectForKey:@"name"]] == NO) {
            self.name = [dict objectForKey:@"name"];
        }
        else {
            self.name = @"";
        }
        
        if ([LogicHelper isNull:[dict objectForKey:@"starting_at"]] == NO) {
            self.startingAt = [LogicHelper getDateFromString:[dict objectForKey:@"starting_at"]];
        }
        else {
            self.startingAt = [NSDate date];
        }
        
        if ([LogicHelper isNull:[dict objectForKey:@"ending_at"]] == NO) {
            self.endingAt = [LogicHelper getDateFromString:[dict objectForKey:@"ending_at"]];
        }
        else {
            self.endingAt = [NSDate date];
        }
        
        self.isTrending = [[dict objectForKey:@"is_trending"] boolValue];
        
    }
    return self;
}


@end
