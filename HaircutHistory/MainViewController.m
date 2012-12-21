//
//  MainViewController.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 19/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import "MainViewController.h"
#import "NewHaircutViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark Actions.

-(void)addHairCut:(UIBarButtonItem *)barButton {
    
    NewHaircutViewController *newHaircutViewController = [[NewHaircutViewController alloc] initWithNibName:@"NewHaircutViewController" bundle:nil];
    [self.navigationController presentViewController:newHaircutViewController animated:YES completion:^{}];
    
}


#pragma mark UIViewController's.

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addHairCut:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
