//
//  XMLParser.m
//  XML
//
//  Created by iPhone SDK Articles on 11/23/08.
//  Copyright 2008 www.iPhoneSDKArticles.com.
//

#import "XMLParser.h"
#import "HamAppDelegate.h"


@implementation XMLParser


- (XMLParser *) initXMLParser {
	
	self = [super init];
	
	appDelegate = (HamAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"Entry"]) {
        appDelegate.callSigns = [[NSMutableArray alloc] init];
		aCallSign = [[CallSign alloc] init];
		aCallSign.ID = 0;
		
		//NSLog(@"Reading id value :%i", aSensor.ID);
	}
	
	//NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	if(!currentElementValue) 
		currentElementValue = [[NSMutableString alloc] initWithString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
	else
		[currentElementValue appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
	NSLog(@"Processing Value: %@", currentElementValue);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"val:Root"])
		return;
	
	if([elementName isEqualToString:@"Entry"]) {
		[appDelegate.callSigns addObject:aCallSign];
		aCallSign = nil;
	}
	else 
		[aCallSign setValue:currentElementValue forKey:elementName];

	currentElementValue = nil;
}



@end
