//
//  HamViewController.m
//  QRZ.si
//
//  Created by Deni Bacic on 22. 01. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import "HamViewController.h"
#import "CallSign.h"
#import "XMLParser.h"
#import "HamAppDelegate.h"
#import "MapViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ZoomViewController.h"

@interface HamViewController ()

@end


@implementation HamViewController

@synthesize labelName, labelCallSign, labelAddress, labelRadioClub, labelPostal, labelEmail, labelLocator, labelQSL, imageAvatar;
@synthesize buttonMap, buttonMail, buttonWeb;
@synthesize callSigns; // xml table parse
@synthesize callSign; // for sending callsign from search


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self launchLoadData];

}

-(void)launchLoadData {
    NSLog(@"Launching thread: LogView");
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD showWhileExecuting:@selector(loadData)
                   onTarget:self
                 withObject:nil
                   animated:YES];
}

- (void) loadData {

    NSLog(@"---> thread launched");
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;

    [self parseXML];

    app.networkActivityIndicatorVisible = NO;
}


-(void) parseXML {
    appDelegate = (HamAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://qrz.si/.andro.php?znak=%@", callSign]];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
	XMLParser *parser = [[XMLParser alloc] initXMLParser];
	[xmlParser setDelegate:parser];
	BOOL success = [xmlParser parse];
	
	if(success)
		NSLog(@"No Errors");
	else {
        [self performSelectorOnMainThread:@selector(alertConnectionError) withObject:@"Napaka!" waitUntilDone:YES];
    }

    
    CallSign *aCallSign = [appDelegate.callSigns objectAtIndex:0];
    
    labelCallSign.text = [[aCallSign.Call stringByReplacingOccurrencesOfString:@"\n" withString:@""] uppercaseString];
    labelName.text = [aCallSign.Name stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    labelAddress.text = [aCallSign.Address stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    labelPostal.text = [aCallSign.Postal stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    labelEmail.text = [aCallSign.Email stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    labelRadioClub.text = [aCallSign.RadioClub stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    labelLocator.text = [aCallSign.Locator stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    labelQSL.text = [aCallSign.QSL stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    
    self.navigationItem.title = [labelCallSign.text uppercaseString];
    
    if ([self.navigationItem.title isEqualToString:@"NI PODATKA"]) {
        [self performSelectorOnMainThread:@selector(alertCallSignNotFound) withObject:@"Napaka!" waitUntilDone:YES];
    }

    
    // Disable button if info is missing
    
    NSString *email = [aCallSign.Email stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *webpage = [aCallSign.Web stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    [labelLocator.text isEqualToString:@"Ni podatka"] ? [self.buttonMap setEnabled:NO]  : [self.buttonMap setEnabled:YES];
    [email isEqualToString:@"Ni podatka"]   ? [self.buttonMail setEnabled:NO] : [self.buttonMail setEnabled:YES];
    [webpage isEqualToString:@"Ni podatka"] ? [self.buttonWeb setEnabled:NO]  : [self.buttonWeb setEnabled:YES];
    
    
    // Show user avatar, if no info, show generic avatar
    NSString *urlString = [[aCallSign.Img stringByReplacingOccurrencesOfString:@"\n"
                                                                    withString:@""]
                        stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURL *imageURL;
    
    if ([urlString isEqualToString:@"Ni%20podatka"]) {
        imageURL = [NSURL URLWithString:@"http://qrz.si/wp-content/plugins/buddypress/bp-core/images/mystery-man.jpg"];
    } else {
        imageURL = [NSURL URLWithString:urlString];
    }
    
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    imageAvatar.image = image;
    
    [imageAvatar.layer setBorderColor: [[UIColor colorWithRed:197/255.0f
                                                        green:179/255.0f
                                                         blue:88/255.0f
                                                        alpha:1.0f]
                                        CGColor]];
    [imageAvatar.layer setBorderWidth: 2.0];
        
}

-(void) alertConnectionError {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Napaka!"
                                                    message: @"Preverite nastavitve povezave in poskusite ponovno!"
                                                   delegate: nil
                                          cancelButtonTitle: @"V redu"
                                          otherButtonTitles: nil];
    [alert show];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) alertCallSignNotFound {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Napaka!"
                                                    message: @"Klicnega znaka ni v bazi QRZ.si!"
                                                   delegate: nil
                                          cancelButtonTitle: @"V redu"
                                          otherButtonTitles: nil];
    [alert show];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"segueMap"]) {
        MapViewController *mapView = [segue destinationViewController];
        mapView.callLocator = labelLocator.text;
        mapView.callSign = [labelCallSign.text uppercaseString];
    } else if ([[segue identifier] isEqualToString:@"segueZoom"]) {
        ZoomViewController *zoomView = [segue destinationViewController];
        zoomView.avatar = imageAvatar.image;
    }
}



- (IBAction)pressWeb:(id)sender {
    CallSign *aCallSign = [appDelegate.callSigns objectAtIndex:0];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[aCallSign.Web stringByReplacingOccurrencesOfString:@"\n"
                                                                                                             withString:@""]]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showEmail:(id)sender {
    CallSign *aCallSign = [appDelegate.callSigns objectAtIndex:0];
    
    
    // Email Subject
    NSString *emailTitle = @"QRZ.si";
    // Email Content
    NSString *messageBody = @"Vaše besedilo.";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:[aCallSign.Email stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (IBAction)imageTap:(UITapGestureRecognizer *)sender {
    
    NSLog(@"TAPPP");
    [self performSegueWithIdentifier:@"segueZoom" sender:self];
}
@end
