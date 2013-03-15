//
//  MapOptionsViewController.m
//  QRZ.si
//
//  Created by Deni Bacic on 6. 02. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import "MapOptionsViewController.h"

@interface MapOptionsViewController ()

@end

@implementation MapOptionsViewController
@synthesize delegate = _delegate;
@synthesize mapTypeSegmentedControl = _mapTypeSegmentedControl;

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
    _mapTypeSegmentedControl.selectedSegmentIndex = _selectedSegmentIndex;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeMapType:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_delegate != nil) {
        [_delegate didCompleteOptionsSelection:sender];
    }
}


- (void)setSelectedSegmentIndex:(NSInteger)index {
    _selectedSegmentIndex = index;
}

- (IBAction)dismissOptions:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (_delegate != nil) {
        [_delegate didCompleteOptionsSelection:nil];
    }
}
@end
