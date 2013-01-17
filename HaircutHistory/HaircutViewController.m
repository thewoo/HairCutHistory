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
        
    [self enterEditMode];
    
    
//    [self.underneathScrollView setScrollEnabled:NO];
//    [self.photosScrollView setScrollEnabled:NO];
    
}

-(void)saveHaircut:(id)sender {
    
    NSLog(@"Saved Haircut. Yay!");
    
}


-(void)enterEditMode {
    
    if (self.haircut == nil) {
        
        [self.companyLabel setText:[NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"haircutViewController.label.company", nil), NSLocalizedString(@"haircutViewController.label.hairdresser", nil)]];
        
        [self.descriptionTextView setText:NSLocalizedString(@"haircutViewController.textView.description", nil)];
        [self.descriptionTextView setTextColor:[UIColor colorWithWhite:0.702 alpha:1.000]];
        
    } else {
        
        // Se rellenan los textFields de editionView;
    }
    
    
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"haircutViewController.barButton.save", nil) style:UIBarButtonSystemItemAction target:self action:@selector(saveHaircut:)];
    
    [saveBarButton setTintColor:[UIColor colorWithRed:0 green:0.613 blue:1 alpha:1]];
    
    [self.navigationItem setRightBarButtonItem:saveBarButton];

    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.underneathScrollView setContentOffset:CGPointMake(0, 0)];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.infoView.frame = CGRectMake(-320, 0, 320, 188);
            self.editionView.frame = CGRectMake(0, 0, 320, 188);
            
        } completion:^(BOOL finished) {
            
            [self placeImagesForEdition];

        }];
    }];
}

-(void)placeImagesForViewing {
    
    for (int x = 0; x < [self.imagesArray count]; x++) {
        
        UIImageView *imageView = [self.imagesArray objectAtIndex:x];
        imageView.frame = CGRectMake(self.photosScrollView.frame.size.width*x, 0, self.photosScrollView.frame.size.width, self.photosScrollView.frame.size.height);
        
        [self.photosScrollView addSubview:imageView];
    }
    
    
}

-(void)placeImagesForEdition {
    
    for (int x = 0; x < [self.imagesArray count]; x++) {
        
        [UIView animateWithDuration:0.5 animations:^{
        
            UIImageView *image = [self.imagesArray objectAtIndex:x];
            
            if (x==0) {
              image.frame = CGRectMake(10, 100, 93, 93);
            
            } else {
                image.frame = CGRectMake(x*(10+93)+10, 100, 93, 93);
            }
        } completion:^(BOOL finished) {
            [self placeDeleteButtons];
        }];
    }
}

-(void)placeDeleteButtons {
    
    for (int x = 0; x < [self.imagesArray count]; x++) {
        
        UIButton *deleteButton;
        
        if (x == 0) {            
            deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(x*(5+93), 85, 0, 0)];
        
        } else {            
            deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(x*(5+93)+5, 85, 0, 0)];
        }
        
        [deleteButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [deleteButton setAlpha:0];
        
        [self.photosScrollView addSubview:deleteButton];
        
        [UIView animateWithDuration:1 animations:^{
            
            if (x == 0) {
                deleteButton.frame = CGRectMake(x*(5+93), 85, 28, 28);
            
            } else {
                deleteButton.frame = CGRectMake(x*(5+93)+5, 85, 28, 28);
            }
            
            [deleteButton setAlpha:1];
        }];
    }
    
    
    
}

-(void)populateImagesArray {
    
    self.imagesArray = [[NSMutableArray alloc] init];
    
    if ([self.haircut.imagesArray count] < 1) {
        
        UIImageView *doctaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"docta"]];
        UIImageView *amyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amy"]];
        UIImageView *roryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rory"]];
        
        [self.imagesArray addObject:doctaImageView];
        [self.imagesArray addObject:amyImageView];
        [self.imagesArray addObject:roryImageView];
        
    }
    
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
    
    
    [self placeImagesForViewing];
    
    
    
    self.infoView.frame = CGRectMake(0, 0, 320, 188);
    [self.underneathScrollView addSubview:self.infoView];
    
    self.editionView.frame = CGRectMake(320, 0, 320, 188);
    [self.underneathScrollView addSubview:self.editionView];
    
    [self.underneathScrollView setContentSize:CGSizeMake(320, self.underneathScrollView.frame.size.height+188)];
    self.underneathScrollView.contentOffset = CGPointMake(0, 188);
    [self.underneathScrollView setShowsVerticalScrollIndicator:NO];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.editMode) {
        
        [self enterEditMode];
        
    } else {
        
        UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"haircutViewController.barButton.edit", nil) style:UIBarButtonSystemItemAction target:self action:@selector(editHaircut:)];
        
        [self.navigationItem setRightBarButtonItem:editBarButton];
        
        self.companyLabel.text = [NSString stringWithFormat:@"%@ : %@", self.haircut.hairdresser.company.name, self.haircut.hairdresser.name];
        self.descriptionTextView.text = self.haircut.shapeDescription;
        [self.ratingImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dstar_big", haircut.rating]]];
    }
    
    [self populateImagesArray];    
    
    self.companyLabel.font = [UIFont fontWithName:@"CreteRound-Regular" size:17.0f];
    self.descriptionTextView.font = [UIFont fontWithName:@"CreteRound-Regular" size:15.0f];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
