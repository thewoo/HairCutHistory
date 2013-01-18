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
#import "StarRating.h"
#import <QuartzCore/QuartzCore.h>


@interface HaircutViewController ()

@end

@implementation HaircutViewController

@synthesize haircut;

BOOL displayingInfoView = NO;
UIColor *placeHolderColor;

#pragma mark Actions.

-(void)editHaircut:(id)sender {
    
    [self enterEditMode];    
}

-(void)saveHaircut:(id)sender {
    
    NSLog(@"Information checked and Saved. *Cough*");
    
    [self removeDeleteButtonsFromView];
    [self leaveEditMode];
}

-(void)deleteImage:(UIButton *)deleteButton {
    
    UIView *image = [self.imagesArray objectAtIndex:deleteButton.tag];
    [image removeFromSuperview];
    [self removeDeleteButtonsFromView];
    [self.imagesArray removeObjectAtIndex:deleteButton.tag];
    
    [self placeImagesForEdition];    
}


-(void)enterEditMode {
    
    [self.underneathScrollView setScrollEnabled:NO];
    
    if (self.haircut == nil) {
        
        self.companyTextField.placeholder = NSLocalizedString(@"haircutViewController.label.company", nil);
        self.hairdresserTextField.placeholder = NSLocalizedString(@"haircutViewController.label.hairdresser", nil);
        
        [self.editingDescriptionTextView setText:NSLocalizedString(@"haircutViewController.textView.description", nil)];
        [self.editingDescriptionTextView setTextColor:placeHolderColor];
        
    } else {
        
        [self.companyTextField setText:self.haircut.hairdresser.company.name];
        [self.hairdresserTextField setText:self.haircut.hairdresser.name];
        
        [self.editingDescriptionTextView setText:self.haircut.shapeDescription];
        [self.editingDescriptionTextView setTextColor:[UIColor whiteColor]];
        
        [self.starRatingView setRating:self.haircut.rating];
    }
    
    
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"haircutViewController.barButton.save", nil) style:UIBarButtonSystemItemAction target:self action:@selector(saveHaircut:)];
    
    [saveBarButton setTintColor:[UIColor colorWithRed:0 green:0.613 blue:1 alpha:1]];
    
    [self.navigationItem setRightBarButtonItem:saveBarButton];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.underneathScrollView setContentOffset:CGPointMake(0, 0)];
        [self.photosScrollView setContentOffset:CGPointMake(0, 0)];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.infoView.frame = CGRectMake(-320, 0, 320, 188);
            self.editionView.frame = CGRectMake(0, 0, 320, 188);
            
        } completion:^(BOOL finished) {
            
            [self placeImagesForEdition];
            
        }];
    }];
}

-(void)leaveEditMode {
    
    [self.underneathScrollView setScrollEnabled:YES];
    
    [self.photosScrollView setContentSize:CGSizeMake([self.imagesArray count]*320, self.photosScrollView.frame.size.height)];
    
    UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"haircutViewController.barButton.edit", nil) style:UIBarButtonSystemItemAction target:self action:@selector(editHaircut:)];
    
    [self.navigationItem setRightBarButtonItem:editBarButton];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.photosScrollView setContentOffset:CGPointMake(0, 0)];        
        [self placeImagesForViewing];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.infoView.frame = CGRectMake(0, 0, 320, 188);
            self.editionView.frame = CGRectMake(320, 0, 320, 188);
            
        } completion:^(BOOL finished) {
            
            [self.underneathScrollView setContentOffset:CGPointMake(0, 188) animated:YES];
        }];
        
    }];
    
    
    
}

-(void)placeImages {
    
    for (int x = 0; x < [self.imagesArray count]; x++) {
        
        UIImageView *imageView = [self.imagesArray objectAtIndex:x];
        imageView.frame = CGRectMake(self.photosScrollView.frame.size.width*x, 0, self.photosScrollView.frame.size.width, self.photosScrollView.frame.size.height);
        
        [self.photosScrollView addSubview:imageView];
    }
}

-(void)placeImagesForViewing {
    
    for (int x = 0; x < [self.imagesArray count]; x++) {
        
        UIImageView *imageView = [self.imagesArray objectAtIndex:x];
        imageView.frame = CGRectMake(self.photosScrollView.frame.size.width*x, 0, self.photosScrollView.frame.size.width, self.photosScrollView.frame.size.height);
    }
}

-(void)placeImagesForEdition {
    
    int numberOfPages = ceil((float)[self.imagesArray count] / 6.0f);
    [self.photosScrollView setContentSize:CGSizeMake(numberOfPages*320, self.photosScrollView.frame.size.height)];
    
    BOOL firstRow = YES;
    
    int actualPage = 0;
    int imageCountPerRow = 0;
    int imageCountPerPage = 0;
    
    for (int x = 0; x < [self.imagesArray count]; x++) {
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            UIImageView *image = [self.imagesArray objectAtIndex:x];
            
            if (firstRow) {
                image.frame = CGRectMake(imageCountPerRow*(10+93)+10+(actualPage*320), 15, 93, 93);
            } else {
                image.frame = CGRectMake(imageCountPerRow*(10+93)+10+(actualPage*320), 30+93, 93, 93);
            }
            
        } completion:^(BOOL finished) {
            
            [self performSelector:@selector(placeDeleteButtons) withObject:nil afterDelay:0.5];            
        }];
        
        
        imageCountPerRow++;
        imageCountPerPage++;
        
        if (imageCountPerRow == 3) {
            imageCountPerRow = 0;
            firstRow = NO;
        }
        
        if (imageCountPerPage == 6) {
            imageCountPerPage = 0;
            firstRow = YES;
            actualPage++;
        }
    }
}

-(void)placeDeleteButtons {
    
    BOOL firstRow = YES;
    
    int actualPage = 0;
    int buttonCountPerRow = 0;
    int buttonCountPerPage = 0;
    
    
    for (int x = 0; x < [self.imagesArray count]; x++) {
        
        UIButton *deleteButton;
        
        if (firstRow) {
            deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonCountPerRow*(5+93)+5+(actualPage*320), 5, 0, 0)];
        } else {
            deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonCountPerRow*(5+93)+5+(actualPage*320), 15+93, 0, 0)];
        }
        
        [deleteButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [deleteButton setAlpha:0];
        [deleteButton setTag:x];
        [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchDown];
        
        [self.photosScrollView addSubview:deleteButton];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            deleteButton.frame = CGRectMake(deleteButton.frame.origin.x, deleteButton.frame.origin.y, 28, 28);
            [deleteButton setAlpha:1];
            
        }];
        
        buttonCountPerRow++;
        buttonCountPerPage++;
        
        if (buttonCountPerRow == 3) {
            buttonCountPerRow = 0;
            firstRow = NO;
        }
        
        if (buttonCountPerPage == 6) {
            buttonCountPerPage = 0;
            firstRow = YES;
            actualPage++;
        }
    }
}

-(void)removeDeleteButtonsFromView {
    
    for (UIView *view in [self.photosScrollView subviews]) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
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
        
        UIImageView *doctaImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"docta"]];
        UIImageView *amyImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amy"]];
        UIImageView *roryImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rory"]];
        
        [self.imagesArray addObject:doctaImageView2];
        [self.imagesArray addObject:amyImageView2];
        [self.imagesArray addObject:roryImageView2];
        
        UIImageView *doctaImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"docta"]];
        UIImageView *amyImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amy"]];
        UIImageView *roryImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rory"]];
        
        [self.imagesArray addObject:doctaImageView3];
        [self.imagesArray addObject:amyImageView3];
        [self.imagesArray addObject:roryImageView3];
        
    
    } else {
        
        for (int x = 0; x < [self.haircut.imagesArray count]; x++) {
            
            NSString *roothPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [roothPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [self.haircut.imagesArray objectAtIndex:x]]];
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]];
            
            [self.imagesArray addObject:imageView];
        }
        
    }
}


#pragma mark UITextField's Delegate.

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UITextView's Delegate.

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (textView.textColor == placeHolderColor) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text length] == 0) {
        [textView setText:NSLocalizedString(@"haircutViewController.textView.description", nil)];
        textView.textColor = placeHolderColor;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return  YES;
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
    [self.photosScrollView setContentSize:CGSizeMake(self.photosScrollView.frame.size.width*[self.imagesArray count], self.photosScrollView.frame.size.height)];
    
    [self.photosScrollView setPagingEnabled:YES];
    [self.photosScrollView setShowsHorizontalScrollIndicator:NO];
    
    
    [self placeImages];
    
    self.infoView.frame = CGRectMake(0, 0, 320, 188);
    [self.underneathScrollView addSubview:self.infoView];
    
    self.editionView.frame = CGRectMake(320, 0, 320, 188);
    [self.underneathScrollView addSubview:self.editionView];
    
    self.starRatingView = [[StarRating alloc] initWithFrame:CGRectMake(77, 135, 166, 28)];
    [self.editionView addSubview:self.starRatingView];
    
    [self.underneathScrollView setContentSize:CGSizeMake(320, self.underneathScrollView.frame.size.height+188)];
    self.underneathScrollView.contentOffset = CGPointMake(0, 188);
    [self.underneathScrollView setShowsVerticalScrollIndicator:NO];
    
    
    
    if (self.editMode) {
        
        [self enterEditMode];
        
    } else {
        
        UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"haircutViewController.barButton.edit", nil) style:UIBarButtonSystemItemAction target:self action:@selector(editHaircut:)];
        
        [self.navigationItem setRightBarButtonItem:editBarButton];
        
        self.companyLabel.text = [NSString stringWithFormat:@"%@ : %@", self.haircut.hairdresser.company.name, self.haircut.hairdresser.name];
        self.descriptionTextView.text = self.haircut.shapeDescription;
        [self.ratingImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dstar_big", haircut.rating]]];
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    placeHolderColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    
    
    
    [self populateImagesArray];
    
    self.editingDescriptionTextView.layer.cornerRadius = 10.0f;
    
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
