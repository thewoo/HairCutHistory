//
//  TestViewController.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 07/01/13.
//  Copyright (c) 2013 MagicDealers. All rights reserved.
//

#import "TestViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TestViewController ()

@end

@implementation TestViewController

@synthesize topView;
@synthesize bottomView;


#pragma mark IBActions.

-(IBAction)doneButtonPressed:(id)sender {
    
    [self hideForm];
}

#pragma mark Actions.

-(void)showForm {
    
    [self.topView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.bottomView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    
    [UIView animateWithDuration:0.5 animations:^{
       
        self.topView.frame = CGRectMake(0, -55, topView.frame.size.width, topView.frame.size.height);
        self.bottomView.frame = CGRectMake(0, 315, bottomView.frame.size.width, bottomView.frame.size.height);
        
    }];
    
}

-(void)hideForm {
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.topView.frame = CGRectMake(0, 0, topView.frame.size.width, topView.frame.size.height);
        self.bottomView.frame = CGRectMake(0, 175, bottomView.frame.size.width, bottomView.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        [self.topView.layer setShadowColor:[[UIColor clearColor] CGColor]];
        [self.bottomView.layer setShadowColor:[[UIColor clearColor] CGColor]];

    }];
    
}


#pragma mark UITextField's Delegate.

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self showForm];
    
    return NO;
}


#pragma mark UIViewController's.

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.topView.layer setShadowOffset:CGSizeMake(0, 5)];
    [self.topView.layer setShadowOpacity:0.5];
    
    [self.bottomView.layer setShadowColor:[[UIColor clearColor] CGColor]];
    [self.bottomView.layer setShadowOffset:CGSizeMake(0, -2)];
    [self.bottomView.layer setShadowOpacity:0.5];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
