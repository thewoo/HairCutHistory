//
//  HaircutCustomCell.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 10/01/13.
//  Copyright (c) 2013 MagicDealers. All rights reserved.
//

#import "HaircutCustomCell.h"

@implementation HaircutCustomCell

#pragma mark UITableViewCell's.


/*-(void)drawRect:(CGRect)rect {
    
//    self.backgroundColor = [UIColor redColor];
    
}*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

@end
