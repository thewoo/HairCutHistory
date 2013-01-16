//
//  NewHaircutViewController.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 19/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import "NewHaircutViewController.h"
#import "DataManager.h"
#import <QuartzCore/QuartzCore.h>

@interface NewHaircutViewController ()

@end

@implementation NewHaircutViewController

@synthesize topView;
@synthesize bottomView;

@synthesize imagesScrollView;

@synthesize addPictureButton;

@synthesize hairdresserTextField;
@synthesize descriptionTextView;

@synthesize companyTextField;

@synthesize takePictureButton;
@synthesize customOverlayView;

@synthesize imagePickerController;

UIColor *placeHolderColor;
bool displayingMenu = NO;

int scrollPoint = 0;

#pragma mark IBActions.

-(IBAction)addPicture:(id)sender {
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self.imagePickerController setCameraDevice:UIImagePickerControllerCameraDeviceRear];
    
    self.imagePickerController.allowsEditing = NO;
    [self.imagePickerController setDelegate:self];
    self.imagePickerController.showsCameraControls = YES;
    self.imagePickerController.navigationBarHidden = YES;
    self.imagePickerController.toolbarHidden = YES;
    
    //    self.imagePickerController.cameraOverlayView = self.customOverlayView;
    
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
}

-(IBAction)takePictureButtonPressed:(id)sender {
    
    [self.imagePickerController takePicture];
}

-(IBAction)editMode:(id)sender {
    
    
    [UIView animateWithDuration:0.5 animations:^{

        self.doctaImageView.frame = CGRectMake(0, 0, 100, 100);
        self.amyImageView.frame = CGRectMake(120, 0, 100, 100);
        self.roryImageView.frame = CGRectMake(240, 0, 100, 100);
        
    }];
    
    
}

#pragma mark Actions.

-(void)showForm {
    
    [self.topView.layer  setShadowColor:[[UIColor blackColor] CGColor]];
    [self.bottomView.layer  setShadowColor:[[UIColor blackColor] CGColor]];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.topView.frame = CGRectMake(0, -210, topView.frame.size.width, topView.frame.size.height);
        self.bottomView.frame = CGRectMake(0, 216, bottomView.frame.size.width, bottomView.frame.size.height);
        
    }];
}

-(void)hideForm {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.topView.frame = CGRectMake(0, 0, topView.frame.size.width, topView.frame.size.height);
        self.bottomView.frame = CGRectMake(0, 260, bottomView.frame.size.width, bottomView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [self.topView.layer  setShadowColor:[[UIColor clearColor] CGColor]];
        [self.bottomView.layer  setShadowColor:[[UIColor clearColor] CGColor]];
    }];
}

-(void)moveTopViewAndForm {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.frame = CGRectMake(0, 216, bottomView.frame.size.width, bottomView.frame.size.height);
    }];
}


-(void)moveTextViewUp {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.topView.frame = CGRectMake(0, -185, self.topView.frame.size.width, self.topView.frame.size.height);
        self.bottomView.frame = CGRectMake(0, 75, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
        
    }];
}


-(void)moveTextViewDown {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.topView.frame = CGRectMake(0, 0, self.topView.frame.size.width, self.topView.frame.size.height);
        self.bottomView.frame = CGRectMake(0, 260, self.bottomView.frame.size.width, self.bottomView.frame.size.height);
        
    }];
    
}


-(void)checkCompany {
    
    if ([[DataManager sharedInstance] checkForCompany:companyTextField.text]) {
        
    } else {
        [self moveTopViewAndForm];
    }
}


-(void)saveHaircut:(id)sender {
    
    NSLog(@"Information checked and Saved. *Cough*");
}


#pragma mark UITextField's Delegate.

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    BOOL beginEditing = YES;
    
    if (textField == hairdresserTextField) {
        
        [self showForm];
        beginEditing = NO;
    }
    
    return beginEditing;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [self hideForm];
    
    return YES;
}

#pragma mark UITextView's Delegate.

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (textView.textColor == placeHolderColor) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    [self moveTextViewUp];
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text length] == 0) {
        [textView setText:NSLocalizedString(@"newHaircutViewController.placeholder.description", nil)];
        textView.textColor = placeHolderColor;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self moveTextViewDown];
    }
    
    return  YES;
}

#pragma mark ScrollView's Delegate.

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x < 1) {
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setPagingEnabled:NO];
        
    } else {
        [scrollView setShowsHorizontalScrollIndicator:YES];
        [scrollView setPagingEnabled:YES];
        
        if (displayingMenu) {
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            displayingMenu = NO;
        }
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView.contentOffset.x < -50) {
        
        if (displayingMenu) {
            
            [UIView animateWithDuration:0.5 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            }];
            
            displayingMenu = NO;
            
        } else {
            
            [UIView animateWithDuration:0.5 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(0, 100, 0, 0);
            }];
            
            displayingMenu = YES;
        }
    }    
}


#pragma mark UIImagePicker Delegate.

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //    UIImage *picture = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"%ddMMyyHHmm"];
    
    NSString *pathWithFile = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@.png", [dateFormatter stringFromDate:[NSDate date]]]];
    
    NSLog(@"%@", pathWithFile);
    
    //    [UIImagePNGRepresentation(picture) writeToFile:pathWithFile atomically:YES];
}

#pragma mark UIViewController's.

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.imagesScrollView setPagingEnabled:YES];
    
    placeHolderColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"newHaircutViewController.button.save", nil) style:UIBarButtonSystemItemAction target:self action:@selector(saveHaircut:)];
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.doctaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"docta"]];
    self.doctaImageView.frame = CGRectMake(0, 0, 320, 200);
    
    self.amyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amy"]];
    self.amyImageView.frame = CGRectMake(320, 0, 320, 200);
    
    self.roryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rory"]];
    self.roryImageView.frame = CGRectMake(640, 0, 320, 200);
    
    
    [self.imagesScrollView addSubview:self.doctaImageView];
    [self.imagesScrollView addSubview:self.amyImageView];
    [self.imagesScrollView addSubview:self.roryImageView];
    
    [self.imagesScrollView setContentSize:CGSizeMake(960, 200)];
    
    [self.topView.layer  setShadowColor:[[UIColor clearColor] CGColor]];
    [self.topView.layer setShadowOffset:CGSizeMake(0, 5)];
    [self.topView.layer setShadowOpacity:0.5];
    
    [self.bottomView.layer setShadowColor:[[UIColor clearColor] CGColor]];
    [self.bottomView.layer setShadowOffset:CGSizeMake(0, -2)];
    [self.bottomView.layer setShadowOpacity:0.5];
    
    [self.doctaImageView.layer setShadowPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, -5, 200)].CGPath];

    [self.doctaImageView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.doctaImageView.layer setShadowOpacity:0.5];
    
    [self.descriptionTextView setText:NSLocalizedString(@"newHaircutViewController.placeholder.description", nil)];
    self.descriptionTextView.textColor = placeHolderColor;
    self.descriptionTextView.layer.cornerRadius = 10.0f;
    
    self.imageMenuView.frame = CGRectMake(-110, 0, 100, 200);
    [self.imagesScrollView addSubview:self.imageMenuView];
    
    
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
