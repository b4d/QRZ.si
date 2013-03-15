//
//  SearchViewController.h
//  QRZ.si
//
//  Created by Deni Bacic on 26. 01. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SearchViewController : UIViewController <MBProgressHUDDelegate> {
    
    MBProgressHUD *HUD;

}
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

- (IBAction)searchPressed:(id)sender;

@end
