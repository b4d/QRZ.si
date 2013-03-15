//
//  XMLParser.h
//  XML
//
//  Created by iPhone SDK Articles on 11/23/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import <UIKit/UIKit.h>
#import "CallSign.h"

@class HamAppDelegate;

@interface XMLParser : NSObject <NSXMLParserDelegate> {

	NSMutableString *currentElementValue;
	
	HamAppDelegate *appDelegate;
    CallSign *aCallSign;
	//Sensor *aSensor;
}

- (XMLParser *) initXMLParser;

@end
