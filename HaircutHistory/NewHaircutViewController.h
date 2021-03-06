//
//  NewHaircutViewController.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 19/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewHaircutViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *topView;
@property (nonatomic, weak) IBOutlet UIView *bottomView;

@property (nonatomic, weak) IBOutlet UIScrollView *imagesScrollView;
@property (nonatomic, strong) IBOutlet UIView *imageMenuView;

@property (nonatomic, weak) IBOutlet UIButton *addPictureButton;

@property (nonatomic, weak) IBOutlet UITextField *hairdresserTextField;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;

@property (nonatomic, weak) IBOutlet UITextField *companyTextField;

@property (nonatomic, strong) IBOutlet UIView *customOverlayView;
@property (nonatomic, weak) IBOutlet UIButton *takePictureButton;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;


@property (nonatomic, strong) UIImageView *doctaImageView;
@property (nonatomic, strong) UIImageView *amyImageView;
@property (nonatomic, strong) UIImageView *roryImageView;


-(IBAction)addPicture:(id)sender;
-(IBAction)takePictureButtonPressed:(id)sender;
-(IBAction)editMode:(id)sender;

@end
