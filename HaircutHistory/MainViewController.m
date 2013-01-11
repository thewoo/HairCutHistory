//
//  MainViewController.m
//  HaircutHistory
//
//  Created by Jorge Pardo on 19/12/12.
//  Copyright (c) 2012 MagicDealers. All rights reserved.
//

#import "MainViewController.h"
#import "NewHaircutViewController.h"
#import "DataManager.h"
#import "Haircut.h"
#import "Hairdresser.h"
#import "Company.h"
#import "HaircutCustomCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize haircutsArray;
@synthesize haircutsTableView;


#pragma mark IBActions.

-(IBAction)sortByDate:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yy"];
    
    self.haircutsArray = [[self.haircutsArray sortedArrayUsingComparator:^(id obj1, id obj2) {
        
        Haircut *one = obj1;
        Haircut *two = obj2;
        
        return (NSComparisonResult) [[dateFormatter dateFromString:two.date] compare:[dateFormatter dateFromString:one.date]];
        
    }] mutableCopy];
    
    [self.haircutsTableView reloadData];
   
}

-(IBAction)sortByRating:(id)sender {
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    
    for (int x=5; x > 0; x--) {
        
        for (Haircut *h in self.haircutsArray) {
            
            if (h.rating == x) {
                [sortedArray addObject:h];
            }
        }
    }
    
    self.haircutsArray = sortedArray;
    [self.haircutsTableView reloadData];
    
}

-(IBAction)sortByHairdresser:(id)sender {
    
    
    
    
    
}

#pragma mark Actions.

-(void)addHairCut:(UIBarButtonItem *)barButton {
    
    NewHaircutViewController *newHaircutViewController = [[NewHaircutViewController alloc] initWithNibName:@"NewHaircutViewController" bundle:nil];
    [self.navigationController pushViewController:newHaircutViewController animated:YES];
}


#pragma mark UITableview's Delegate & Datasource.

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [haircutsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HaircutCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[HaircutCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Haircut *haircut = [haircutsArray objectAtIndex:[indexPath row]];
    
    cell.companyLabel.text = haircut.hairdresser.company.name;
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", haircut.date];
    [cell.ratingImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dstar", haircut.rating]]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    return 55;
}




#pragma mark UIViewController's.

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addHairCut:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.haircutsArray = [[DataManager sharedInstance] getAllHaircuts];
    
    [self.haircutsTableView registerNib:[UINib nibWithNibName:@"HaircutCustomCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.sortByDateButton setTitle:NSLocalizedString(@"newHaircutViewController.button.sortByDate", nil) forState:UIControlStateNormal];
    [self.sortByRatingButton setTitle:NSLocalizedString(@"newHaircutViewController.button.sortByRating", nil) forState:UIControlStateNormal];
    [self.sortByHairdresserButton setTitle:NSLocalizedString(@"newHaircutViewController.button.sortByHairdresser", nil) forState:UIControlStateNormal];
    
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
