//
//  StarRating.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 17/01/13.
//  Copyright (c) 2013 MagicDealers. All rights reserved.
//

#import "StarRating.h"

@implementation StarRating

-(void)setRating:(int)rating {
    
    _rating = rating;
    
    [self.starsImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dstar_rating", rating]]];
}

#pragma mark Actions.

-(void)changeStarRatingImage:(CGPoint)points {
    
    if (points.x < 0 && self.rating != 0) {
        self.rating = 0;
        
    } else if (points.x > 0 && points.x < 35 && self.rating != 1) {
        self.rating = 1;
        
    } else if (points.x > 35 && points.x < 65 && self.rating != 2) {
        self.rating = 2;
        
    } else if (points.x > 65 && points.x < 100 && self.rating != 3) {
        self.rating = 3;
        
    } else if (points.x > 100 && points.x < 135 && self.rating != 4) {
        self.rating = 4;
        
    } else if (points.x > 135 && self.rating != 5) {
        self.rating = 5;
    }
    
}



#pragma mark UIView's.

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint points = [[touches anyObject] locationInView:self];
    [self changeStarRatingImage:points];
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint points = [[touches anyObject] locationInView:self];
    [self changeStarRatingImage:points];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.starsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.starsImageView setImage:[UIImage imageNamed:@"0star_rating"]];
        
        [self addSubview:self.starsImageView];
        
    }
    return self;
}


@end
