//
//  DetailsViewController.h
//  FCI
//
//  Created by Stefan Andric on 10/6/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIImage *image;
@end
