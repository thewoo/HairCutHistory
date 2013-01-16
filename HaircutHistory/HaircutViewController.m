//
//  ViewHaircutViewController.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 14/01/13.
//  Copyright (c) 2013 MagicDealers. All rights reserved.
//

#import "HaircutViewController.h"
#import "Haircut.h"
#import "Hairdresser.h"
#import "Company.h"

@interface HaircutViewController ()

@end

@implementation HaircutViewController

@synthesize haircut;

BOOL displayingInfoView = NO;

#pragma mark Actions.

-(void)editHaircut:(id)sender {
    
    NSLog(@"Enter Edit State, of course");
    
    [self enterEditMode];
    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        self.infoView.frame = CGRectMake(-320, 0, 320, 188);
//        self.editionView.frame = CGRectMake(0, 0, 320, 188);
//        
//    }];
    
//    [self.underneathScrollView setScrollEnabled:NO];
//    [self.photosScrollView setScrollEnabled:NO];
}

-(void)saveHaircut:(id)sender {
    
    NSLog(@"Saved Haircut. Yay!");
    
}


-(void)enterEditMode {

    [UIView animateWithDuration:0.5 animations:^{
        [self.underneathScrollView setContentOffset:CGPointMake(188, 0)];
    }];
    
    
    
}


#pragma mark UIScrollView's Delegate.

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    
    if (displayingInfoView == NO) {
        
        if (self.underneathScrollView.contentOffset.y < 188) {

            [self.underneathScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            displayingInfoView = YES;
        }

    } else {
        
        if (self.underneathScrollView.contentOffset.y < 0) {
            
            [self.underneathScrollView setContentOffset:CGPointMake(0, 188) animated:YES];
            displayingInfoView = NO;
        }
    }
}




#pragma mark UIViewController's.

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.photosScrollView.frame = CGRectMake(0, 188, self.photosScrollView.frame.size.width, self.underneathScrollView.frame.size.height);
    [self.photosScrollView setContentSize:CGSizeMake(960, self.photosScrollView.frame.size.height)];
    
    [self.photosScrollView setPagingEnabled:YES];
    [self.photosScrollView setShowsHorizontalScrollIndicator:NO];
    
    
    UIImageView *doctaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"docta"]];
    doctaImageView.frame = CGRectMake(0, 0, self.photosScrollView.frame.size.width, self.photosScrollView.frame.size.height);
    
    UIImageView *amyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amy"]];
    amyImageView.frame = CGRectMake(320, 0, self.photosScrollView.frame.size.width, self.photosScrollView.frame.size.height);
    
    UIImageView *roryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rory"]];
    roryImageView.frame = CGRectMake(640, 0, self.photosScrollView.frame.size.width, self.photosScrollView.frame.size.height);
    
    [self.photosScrollView addSubview:doctaImageView];
    [self.photosScrollView addSubview:amyImageView];
    [self.photosScrollView addSubview:roryImageView];
    
    
    self.infoView.frame = CGRectMake(0, 0, 320, 188);
    [self.underneathScrollView addSubview:self.infoView];
    
    self.editionView.frame = CGRectMake(320, 0, 320, 188);
    [self.underneathScrollView addSubview:self.editionView];
    
    [self.underneathScrollView setContentSize:CGSizeMake(320, self.underneathScrollView.frame.size.height+188)];
    self.underneathScrollView.contentOffset = CGPointMake(0, 188);
    [self.underneathScrollView setShowsVerticalScrollIndicator:NO];
    
    
    
    self.companyLabel.text = [NSString stringWithFormat:@"%@ : %@", self.haircut.hairdresser.company.name, self.haircut.hairdresser.name];
    self.descriptionTextView.text = self.haircut.shapeDescription;
    [self.ratingImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dstar_big", haircut.rating]]];
    
    self.companyLabel.font = [UIFont fontWithName:@"CreteRound-Regular" size:17.0f];
    self.descriptionTextView.font = [UIFont fontWithName:@"CreteRound-Regular" size:15.0f];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.editMode) {
        
        [self enterEditMode];
        
        UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"haircutViewController.barButton.save", nil) style:UIBarButtonSystemItemAction target:self action:@selector(saveHaircut:)];
        
        [saveBarButton setTintColor:[UIColor colorWithRed:0 green:0.613 blue:1 alpha:1]];
        
        [self.navigationItem setRightBarButtonItem:saveBarButton];
        
    } else {
        
        UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"haircutViewController.barButton.edit", nil) style:UIBarButtonSystemItemAction target:self action:@selector(editHaircut:)];
        
        [self.navigationItem setRightBarButtonItem:editBarButton];
    }
    
    
            
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
