//
//  MapPin.m
//  QRZ.si
//
//  Created by Deni Bacic on 27. 01. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import "MapPin.h"


@implementation MapPin

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location placeName:placeName description:description {
    self = [super init];
    if (self != nil) {
        coordinate = location;
        title = placeName;
        subtitle = description;
    }
    return self;
}

- (void)dealloc {

}


@end