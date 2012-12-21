//
//  NewHaircutViewController.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 19/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import "NewHaircutViewController.h"

@interface NewHaircutViewController ()

@end

@implementation NewHaircutViewController

@synthesize imagesScrollView;

@synthesize addPictureButton;

@synthesize takePictureButton;
@synthesize customOverlayView;

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
