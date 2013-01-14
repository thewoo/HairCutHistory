//
//  ViewHaircutViewController.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 14/01/13.
//  Copyright (c) 2013 MagicDealers. All rights reserved.
//

#import "ViewHaircutViewController.h"
#import "Haircut.h"

@interface ViewHaircutViewController ()

@end

@implementation ViewHaircutViewController

@synthesize haircut;

BOOL displayingInfoView = NO;

#pragma mark UIScrollView's Delegate.

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.underneathScrollView.contentOffset.y < 0) {
        
        if (displayingInfoView) {
            
            [UIView animateWithDuration:0.5 animations:^{
                [self.underneathScrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            }];
            
            displayingInfoView = NO;
            
        } else {
            
            [UIView animateWithDuration:0.5 animations:^{                
                [self.underneathScrollView setContentInset:UIEdgeInsetsMake(188, 0, 0, 0)];                
            }];
            
            displayingInfoView = YES;
        }
    }
}



#pragma mark UIViewController's.

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *doctaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"docta"]];
    doctaImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    
    UIImageView *amyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amy"]];
    amyImageView.frame = CGRectMake(320, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    
    UIImageView *roryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rory"]];
    roryImageView.frame = CGRectMake(640, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    
    
    [self.photosScrollView addSubview:doctaImageView];
    [self.photosScrollView addSubview:amyImageView];
    [self.photosScrollView addSubview:roryImageView];
    
    [self.photosScrollView setContentSize:CGSizeMake(960, self.view.frame.size.height-44)];
    [self.photosScrollView setPagingEnabled:YES];
    
    self.infoView.frame = CGRectMake(0, -188, 320, 188);
    [self.underneathScrollView addSubview:self.infoView];
    
    [self.underneathScrollView setContentSize:CGSizeMake(320, self.view.frame.size.height-40)];
    
    self.descriptionTextView.text = self.haircut.shapeDescription;
    [self.ratingImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dstar_big", haircut.rating]]];
    
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
