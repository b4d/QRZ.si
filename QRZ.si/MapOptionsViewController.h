//
//  MapOptionsViewController.h
//  QRZ.si
//
//  Created by Deni Bacic on 6. 02. 13.
//  Copyright (c) 2013 Deni Bacic. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MapOptionsViewControllerDelegate <NSObject>
- (void)didCompleteOptionsSelection:(id)sender;
@end


@interface MapOptionsViewController : UIViewController {

@private
    __weak id <MapOptionsViewControllerDelegate> _delegate;
    __weak UISegmentedControl *_mapTypeSegmentedControl;
    
    NSInteger _selectedSegmentIndex;
    
    
}
- (IBAction)changeMapType:(id)sender;

@property (weak, nonatomic) id <MapOptionsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypeSegmentedControl;

- (void)setSelectedSegmentIndex:(NSInteger)index;
- (IBAction)dismissOptions:(id)sender;

@end
