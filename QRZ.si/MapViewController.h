//
//  MapViewController.h
//  QRZ.si
//
//  Created by Deni Bacic on 25. 01. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapOptionsViewController.h"

@interface MapViewController : UIViewController<MKMapViewDelegate, MapOptionsViewControllerDelegate> {
    IBOutlet CLLocationManager *locationManager;
    MKMapView *myMapView;
    
    NSString *callLocator;
    NSString *callSign;
    
    NSInteger _currentMapType;
}

@property (nonatomic, retain) IBOutlet MKMapView *myMapView;
@property (nonatomic,strong) NSString *callLocator;
@property (nonatomic,strong) NSString *callSign;
- (IBAction)pressCenterMap:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;

@end


