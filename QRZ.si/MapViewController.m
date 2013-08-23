//
//  MapViewController.m
//  QRZ.si
//
//  Created by Deni Bacic on 25. 01. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import "MapViewController.h"

//#import "MapPin.h"

#import "Maidenhead.h"



@implementation MapViewController

@synthesize myMapView, callLocator, callSign, labelDistance;


- (void)viewDidLoad
{
    _currentMapType = 0;
    
    [self.navigationController setToolbarHidden:YES];
    myMapView.delegate = self;
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 3.1f;
    span.longitudeDelta = 3.1f;
    
    
    region.span = span;
    region.center = CLLocationCoordinate2DMake(46.119944,14.815333); //geoss
    
    
    Coordinates locator = [Maidenhead fromMaidenhead:callLocator];

    // current location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D locatorRectangleCoords[5]={
		CLLocationCoordinate2DMake(locator.lat+0.02,locator.lon-0.04),
        CLLocationCoordinate2DMake(locator.lat+0.02,locator.lon+0.04),
        CLLocationCoordinate2DMake(locator.lat-0.02,locator.lon+0.04),
        CLLocationCoordinate2DMake(locator.lat-0.02,locator.lon-0.04),
        CLLocationCoordinate2DMake(locator.lat+0.02,locator.lon-0.04)
	};
    
    MKPolygon *locatorPolygon=[MKPolygon polygonWithCoordinates:locatorRectangleCoords count:5];
	[myMapView addOverlay:locatorPolygon];
    

    CLLocation *apple = [[CLLocation alloc] initWithLatitude:locator.lat
                                                   longitude:locator.lon];
    CLLocation *me = [[CLLocation alloc] initWithLatitude:locationManager.location.coordinate.latitude
                                                longitude:locationManager.location.coordinate.longitude];
    
    
    float distance = [apple distanceFromLocation:me]/1000;
    
    self.title = callLocator;
    self.labelDistance.text = [NSString stringWithFormat:@"%.0f km", distance];
    


    [self.myMapView setRegion:region animated:NO];
    
    [self performSelector:@selector(zoomInToMyLocation)
               withObject:nil
               afterDelay:2];
    
    [super viewDidLoad];
    
}


-(void)zoomInToMyLocation {
    Coordinates locator = [Maidenhead fromMaidenhead:callLocator];
    CLLocationCoordinate2D myCoordinate = {locator.lat, locator.lon};
    
    MKCoordinateRegion region;
    region.center = myCoordinate;
    region.span.longitudeDelta = 0.2;
    region.span.latitudeDelta = 0.2;
    [self.myMapView setRegion:region animated:YES];
}


-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
	if([overlay isKindOfClass:[MKPolygon class]]){
		MKPolygonView *view = [[MKPolygonView alloc] initWithOverlay:overlay];
		view.lineWidth=5;
		view.strokeColor=[UIColor colorWithRed:197/255.0f
                                         green:179/255.0f
                                          blue:88/255.0f
                                         alpha:1.0f];
		view.fillColor=[UIColor colorWithRed:197/255.0f
                                       green:179/255.0f
                                        blue:88/255.0f
                                       alpha:0.4f];
		return view;
	}
	return nil;
}



- (IBAction)pressCenterMap:(UIBarButtonItem *)sender {
    
    [self performSelector:@selector(zoomInToMyLocation)
               withObject:nil
               afterDelay:0];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MapOptionsViewController *mapOptionsViewController = segue.destinationViewController;
    
    mapOptionsViewController.delegate = self;
    [mapOptionsViewController setSelectedSegmentIndex:_currentMapType];
}

- (void)didCompleteOptionsSelection:(id)sender {
    if (sender != nil) {
        UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
        
        NSInteger index = segmentedControl.selectedSegmentIndex;
        switch (index) {
            case 0:
                myMapView.mapType = MKMapTypeStandard;
                break;
            case 1:
                myMapView.mapType = MKMapTypeHybrid;
                break;
            case 2:
                myMapView.mapType = MKMapTypeSatellite;
                break;
            default:
                index = 0;
                myMapView.mapType = MKMapTypeStandard;
                break;
        }
        
        _currentMapType = index;
    }
}

- (void)applyMapViewMemoryHotFix{
    
    switch (self.myMapView.mapType) {
        case MKMapTypeHybrid:
        {
            self.myMapView.mapType = MKMapTypeStandard;
        }
            
            break;
        case MKMapTypeStandard:
        {
            self.myMapView.mapType = MKMapTypeHybrid;
        }
            
            break;
        default:
            break;
    }
    self.myMapView.showsUserLocation = NO;
    self.myMapView.delegate = nil;
    [self.myMapView removeFromSuperview];
    self.myMapView = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self applyMapViewMemoryHotFix];
    NSLog(@"fixxxin map memory");
}

@end
