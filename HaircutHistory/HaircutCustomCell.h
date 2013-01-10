//
//  HaircutCustomCell.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 10/01/13.
//  Copyright (c) 2013 MagicDealers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HaircutCustomCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *previewImageView;
@property (nonatomic, weak) IBOutlet UILabel *companyLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *myBkgView;

@end
