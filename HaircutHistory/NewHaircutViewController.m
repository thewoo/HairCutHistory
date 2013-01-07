//
//  NewHaircutViewController.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 19/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import "NewHaircutViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NewHaircutViewController ()

@end

@implementation NewHaircutViewController

@synthesize topView;
@synthesize bottomView;

@synthesize imagesScrollView;

@synthesize addPictureButton;

@synthesize takePictureButton;
@synthesize customOverlayView;

@synthesize hairdresserLabel;
@synthesize hairdresserTextField;

@synthesize imagePickerController;

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
    
    
    UIImageView *doctaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"docta"]];
    doctaImageView.frame = CGRectMake(0, 0, 320, 200);
    
    UIImageView *amyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amy"]];
    amyImageView.frame = CGRectMake(320, 0, 320, 200);
    
    UIImageView *roryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rory"]];
    roryImageView.frame = CGRectMake(640, 0, 320, 200);
    
    
    [self.imagesScrollView addSubview:doctaImageView];
    [self.imagesScrollView addSubview:amyImageView];
    [self.imagesScrollView addSubview:roryImageView];
    
    [self.imagesScrollView setContentSize:CGSizeMake(960, 200)];
    
    [self.topView.layer  setShadowColor:[[UIColor clearColor] CGColor]];
    [self.topView.layer setShadowOffset:CGSizeMake(0, 5)];
    [self.topView.layer setShadowOpacity:0.5];
    
    [self.bottomView.layer  setShadowColor:[[UIColor clearColor] CGColor]];
    [self.bottomView.layer setShadowOffset:CGSizeMake(0, -2)];
    [self.bottomView.layer setShadowOpacity:0.5];
    
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
