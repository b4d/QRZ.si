//
//  ZoomViewController.h
//  QRZ.si
//
//  Created by Deni Bacic on 6. 03. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomViewController : UIViewController {

}

- (IBAction)returnTap:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIImage *avatar;

@end
