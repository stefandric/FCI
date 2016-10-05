//
//  ImageObject.m
//  FCI
//
//  Created by Stefan Andric on 10/5/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import "ImageObject.h"
#import "LogicHelper.h"

@implementation ImageObject

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if ([LogicHelper isNull:[dict objectForKey:@"image"]] == NO) {
            self.imageUrl = [NSURL URLWithString:[dict objectForKey:@"image"]];
        }
        else {
            self.imageUrl = [NSURL URLWithString:@""];
        }
        
        if ([LogicHelper isNull:[dict objectForKey:@"description"]] == NO) {
            self.descriptionOfImage = [dict objectForKey:@"description"];
        }
        else {
            self.imageUrl = [NSURL URLWithString:@""];
        }
        
        
    }
    return self;
}
@end
