//
//  NewHaircutViewController.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 19/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewHaircutViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *imagesScrollView;

@property (nonatomic, weak) IBOutlet UIButton *addPictureButton;

@property (nonatomic, strong) IBOutlet UIView *customOverlayView;
@property (nonatomic, weak) IBOutlet UIButton *takePictureButton;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

-(IBAction)addPicture:(id)sender;
-(IBAction)takePictureButtonPressed:(id)sender;

@end