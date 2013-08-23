//
//  HamViewController.h
//  QRZ.si
//
//  Created by Deni Bacic on 22. 01. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h> 

@class HamAppDelegate;

@interface HamViewController : UIViewController <MBProgressHUDDelegate, MFMailComposeViewControllerDelegate> {
    
    HamAppDelegate *appDelegate;
    
    MBProgressHUD *HUD;
    
}


- (IBAction)showEmail:(id)sender;

@property (nonatomic,strong) NSString *callSign;
@property (nonatomic, strong) NSMutableArray *callSigns;

@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelCallSign;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelRadioClub;
@property (weak, nonatomic) IBOutlet UILabel *labelPostal;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;
@property (weak, nonatomic) IBOutlet UILabel *labelLocator;
@property (weak, nonatomic) IBOutlet UILabel *labelQSL;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonWeb;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonMap;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonMail;

- (IBAction)imageTap:(UITapGestureRecognizer *)sender;

@end
