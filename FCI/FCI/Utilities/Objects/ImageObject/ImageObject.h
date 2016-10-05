//
//  ImageObject.h
//  FCI
//
//  Created by Stefan Andric on 10/5/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageObject : NSObject
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) NSString *descriptionOfImage;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
