//
//  Communication.h
//  FCI
//
//  Created by Stefan Andric on 10/5/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Communication : NSObject

+ (void)getAllAnnotationsWithSuccessBlock:(void (^)(NSArray *annotations))successBlock
                          andFailureBlock:(void (^)(NSDictionary *error))errorBlock;

+ (void)getAllImagesForId:(NSInteger)idOfEvent
         withSuccessBlock:(void (^)(NSArray *images))successBlock
          andFailureBlock:(void (^)(NSDictionary *error))errorBlock;
@end
