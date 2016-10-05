//
//  HomeViewController.m
//  FCI
//
//  Created by Stefan Andric on 10/5/16.
//  Copyright © 2016 stefandric. All rights reserved.
//

#import "HomeViewController.h"
#import "Communication.h"
#import "CustomGMSMarker.h"
#import "HomeImageCollectionViewCell.h"
#import "ImageObject.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"


@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet GMSMapView *googleMapView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIImage *imageToTransfer;
@property (nonatomic, strong) NSString *transferText;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMap];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Map manipulation
- (void)setupMap {
    [self askForPermissions];
    
    //According to Google documentation, zoom level for presenting city should be 10
    GMSCameraPosition *belgrade = [GMSCameraPosition cameraWithLatitude:44.787197
                                                              longitude:20.457273
                                                                   zoom:10];
    [self.googleMapView setCamera:belgrade];
    self.googleMapView.delegate = self;
    self.googleMapView.myLocationEnabled = YES;
    [self getNewestPins];
    
}

- (void)getNewestPins {
    [Communication getAllAnnotationsWithSuccessBlock:^(NSArray *annotations) {
        for (CustomGMSMarker *marker in annotations) {
            marker.map = self.googleMapView;
        }
    } andFailureBlock:^(NSDictionary *error) {
        
    }];
}

- (void)askForPermissions
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    CustomGMSMarker *markerWithId = (CustomGMSMarker *)marker;
    NSLog(@"tapped %ld", (long)markerWithId.idOfEvent);
    GMSCameraPosition *belgrade = [GMSCameraPosition cameraWithLatitude:marker.position.latitude
                                                              longitude:marker.position.longitude
                                                                   zoom:15];
    [self.googleMapView setCamera:belgrade];
    
    
    if (self.collectionView == nil) {
        [self setupCollection];
    }
    
    [Communication getAllImagesForId:markerWithId.idOfEvent withSuccessBlock:^(NSArray *images) {
        self.images = [NSArray arrayWithArray:images];
        if (self.images.count < 1) {
            [self.collectionView removeFromSuperview];
            self.collectionView = nil;
        }
        else {
        [self.collectionView reloadData];
        }
        
    } andFailureBlock:^(NSDictionary *error) {
        
    }];
    
    
    return NO; //Showing native annotation view
}


#pragma mark - CollectionDelegates
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ImageObject *imageObject = self.images[indexPath.row];
    
    [cell.eventImageView setImageWithURLRequest:[NSURLRequest requestWithURL:imageObject.imageUrl] placeholderImage:[UIImage imageNamed:@"question-mark_318-52837"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        cell.eventImageView.image = image;
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeImageCollectionViewCell *cell = (HomeImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    self.imageToTransfer = cell.eventImageView.image;
    ImageObject *object = self.images[indexPath.row];
    self.transferText = object.descriptionOfImage;
    
    [self performSegueWithIdentifier:@"toFull" sender:self];
}

- (void)setupCollection
{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.googleMapView.frame.size.height-100, self.googleMapView.frame.size.width, 100) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.googleMapView addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

}

 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"toFull"]) {
         DetailsViewController *vc = [segue destinationViewController];
         vc.image = self.imageToTransfer;
         vc.text = self.transferText;
     }
     
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 

@end
