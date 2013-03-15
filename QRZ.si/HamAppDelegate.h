//
//  HamAppDelegate.h
//  QRZ.si
//
//  Created by Deni Bacic on 22. 01. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

/*  
 Version 1.0.3 (X.3.2013):
    - MapView: golden bottom bar and locator rectangle
 
 
 
 Version 1.0.3 (6.3.2013):
    - Changed splash image for better user experience
    - Changed tint color of navigation bar, toolbar and avatar border
    - Avatar zoom on tap
 
 
 Version 1.0.2:
    - Image fetching from gravatar works now
    - Added avatar border
    - Tweaked info display
 
    TODO: save map type selection
 
 
 Version 1.0.1:
    - bugfix: map, always shown the same locator
    - map: removed pin, added distance to bottom bar and locator to top
    - map: added map type selection in curl page view
    - hamVC: name label fixed and streched
    - hamVC: fixed default values when initializing the view
    - search: fixed default text value
    - removed MapPin.h/MapPin.m, now obsolete
 
 */

#import <UIKit/UIKit.h>

@interface HamAppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableArray *callSigns;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSMutableArray *callSigns;

@end
