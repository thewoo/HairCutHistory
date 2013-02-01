//
//  ViewHaircutViewController.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 14/01/13.
//  Copyright (c) 2013 MagicDealers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HairStyle;
@class StarRating;

@interface HairStyleViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate>

@property BOOL editMode;

@property (nonatomic, strong) IBOutlet UIScrollView *underneathScrollView;
@property (nonatomic, strong) IBOutlet UIScrollView *photosScrollView;

@property (nonatomic, strong) HairStyle *hairStyle;
@property (nonatomic, strong) NSMutableArray *imagesArray;

@property (nonatomic, strong) IBOutlet UIView *infoView;

@property (nonatomic, weak) IBOutlet UILabel *companyLabel;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UIImageView *ratingImageView;

@property (nonatomic, strong) IBOutlet UIView *editionView;

@property (nonatomic, weak) IBOutlet UISwitch *professionalSwitch;
@property (nonatomic, weak) IBOutlet UILabel *professionalLabel;
@property (nonatomic, weak) IBOutlet UITextField *companyTextField;
@property (nonatomic, weak) IBOutlet UITextField *hairdresserTextField;
@property (nonatomic, weak) IBOutlet UITextView *editingDescriptionTextView;

@property (nonatomic, strong) StarRating *starRatingView;

@property (nonatomic, strong) UIView *alphaBackGroundView;
@property (nonatomic, strong) UIView *chooseImageSourceView;
@property (nonatomic, strong) UIView *shareView;

@end
