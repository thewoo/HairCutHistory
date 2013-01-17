//
//  ViewHaircutViewController.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 14/01/13.
//  Copyright (c) 2013 MagicDealers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Haircut.h"

@interface HaircutViewController : UIViewController <UIScrollViewDelegate>

@property BOOL editMode;

@property (nonatomic, strong) IBOutlet UIScrollView *underneathScrollView;
@property (nonatomic, strong) IBOutlet UIScrollView *photosScrollView;

@property (nonatomic, strong) Haircut *haircut;
@property (nonatomic, strong) NSMutableArray *imagesArray;

@property (nonatomic, strong) IBOutlet UIView *infoView;
@property (nonatomic, strong) IBOutlet UIView *editionView;

@property (nonatomic, weak) IBOutlet UILabel *companyLabel;

@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UIImageView *ratingImageView;

@end
