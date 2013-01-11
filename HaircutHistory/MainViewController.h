//
//  MainViewController.h
//  HaircutHistory
//
//  Created by Jorge Pardo on 19/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *haircutsArray;
@property (nonatomic, weak) IBOutlet UITableView *haircutsTableView;

@property (nonatomic, weak) IBOutlet UIButton *sortByDateButton;
@property (nonatomic, weak) IBOutlet UIButton *sortByRatingButton;
@property (nonatomic, weak) IBOutlet UIButton *sortByHairdresserButton;


-(IBAction)sortByDate:(id)sender;
-(IBAction)sortByRating:(id)sender;
-(IBAction)sortByHairdresser:(id)sender;

@end
