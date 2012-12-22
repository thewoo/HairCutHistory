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


@end
