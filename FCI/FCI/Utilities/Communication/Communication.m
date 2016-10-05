//
//  Communication.m
//  FCI
//
//  Created by Stefan Andric on 10/5/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import "Communication.h"
#import "AFNetworking.h"
#import "AnnotationObject.h"
#import "CustomGMSMarker.h"
#import "ImageObject.h"
@import GoogleMaps;

#define BASE_URL @"http://private-60f2d-eventer2.apiary-mock.com"

@implementation Communication

+ (void)getAllAnnotationsWithSuccessBlock:(void (^)(NSArray *annotations))successBlock
                          andFailureBlock:(void (^)(NSDictionary *error))errorBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:@"%@/api/v1/events", BASE_URL] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *annotationsToShow = [NSMutableArray new];
        NSArray *annotations = (NSArray *)responseObject;
        
        for (NSDictionary *annotation in annotations) {
            AnnotationObject *tempObj = [[AnnotationObject alloc] initWithDictionary:annotation];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(tempObj.latitude, tempObj.longitude);
            
            CustomGMSMarker *marker = [CustomGMSMarker new];
            marker.position = coordinate;
            marker.title = tempObj.name;
            marker.idOfEvent = tempObj.idAnnotation;
            
            if ([tempObj.endingAt compare:[NSDate date]] == NSOrderedAscending) {
                marker.icon = [GMSMarker markerImageWithColor:[UIColor grayColor]];
            }
            else {
                if (tempObj.isTrending == YES) {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor yellowColor]];
                }
                else {
                    marker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
                }
            }
            
            [annotationsToShow addObject:marker];
            
            
        }
        
        
        successBlock(annotationsToShow);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)getAllImagesForId:(NSInteger)idOfEvent
         withSuccessBlock:(void (^)(NSArray *images))successBlock
          andFailureBlock:(void (^)(NSDictionary *error))errorBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@/api/v1/events/%ld", BASE_URL, (long)idOfEvent];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *images = (NSArray *)responseObject;
        NSMutableArray *imagesObjects = [NSMutableArray new];
        
        for (NSDictionary *image in images) {
            ImageObject *imageObject = [[ImageObject alloc] initWithDictionary:image];
            [imagesObjects addObject:imageObject];
            
        }
        
        successBlock(imagesObjects);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
