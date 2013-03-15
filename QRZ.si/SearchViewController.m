//
//  SearchViewController.m
//  QRZ.si
//
//  Created by Deni Bacic on 26. 01. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import "SearchViewController.h"
#import "HamViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize searchTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //[self.navigationController setToolbarHidden:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:197/255.0f
                                                                          green:179/255.0f
                                                                           blue:88/255.0f
                                                                          alpha:1.0f]];
    //197,179,88
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchPressed:(id)sender {
    NSLog(@"PRESS");
    [self.searchTextField resignFirstResponder];
    
    NSCharacterSet *alphanumericSet = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
    BOOL isAplhaNumericOnly= [[self.searchTextField.text stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] && ![[self.searchTextField.text stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
    
    
    
    if(isAplhaNumericOnly) {
		NSLog(@"No Errors");
        [self performSegueWithIdentifier:@"search" sender:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Napaka!"
                                                        message: @"Preverite obliko iskanega klicnega znaka in poskusite ponovno!"
                                                       delegate: nil
                                              cancelButtonTitle: @"V redu"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
}
- (IBAction)backgroundPressed:(id)sender {
    [self.searchTextField resignFirstResponder];
        NSLog(@"PRESS");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"search"]) {
        HamViewController *hamView = [segue destinationViewController];
        hamView.callSign = searchTextField.text;
    }
}
@end
