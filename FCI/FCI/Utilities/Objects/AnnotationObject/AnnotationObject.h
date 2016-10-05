//
//  AnnotationObject.h
//  FCI
//
//  Created by Stefan Andric on 10/5/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnotationObject : NSObject
@property (nonatomic, assign) NSInteger idAnnotation;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *startingAt;
@property (nonatomic, strong) NSDate *endingAt;
@property (nonatomic, assign) BOOL isTrending;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
