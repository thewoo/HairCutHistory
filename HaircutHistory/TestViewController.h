//
//  TestViewController.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 07/01/13.
//  Copyright (c) 2013 MagicDealers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIView *topView;
@property (nonatomic, weak) IBOutlet UIView *bottomView;

@property (nonatomic, weak) IBOutlet UITextField *companyTextField;

@property (nonatomic, weak) IBOutlet UIButton *doneButton;

-(IBAction)doneButtonPressed:(id)sender;




@end
