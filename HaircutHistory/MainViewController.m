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
#import "HaircutViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize haircutsArray;
@synthesize haircutsTableView;

BOOL ascendingDate = YES;
BOOL ascendingRating = YES;

#pragma mark IBActions.

-(IBAction)sortByDate:(id)sender {
    
    ascendingRating = YES;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yy"];
    
    self.haircutsArray = [[self.haircutsArray sortedArrayUsingComparator:^(id obj1, id obj2) {
        
        Haircut *one = obj1;
        Haircut *two = obj2;
        
        int comparisonResult = 0;
        
        if (ascendingDate) {
            comparisonResult = [[dateFormatter dateFromString:one.date] compare:[dateFormatter dateFromString:two.date]];
        
        } else  {
            comparisonResult = [[dateFormatter dateFromString:two.date] compare:[dateFormatter dateFromString:one.date]];
        }
        
        return (NSComparisonResult) comparisonResult;
        
    }] mutableCopy];
    
    ascendingDate = !ascendingDate;
    
    [self.haircutsTableView reloadData];
    
}

-(IBAction)sortByRating:(id)sender {
    
    ascendingDate = YES;
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    
    if (ascendingRating) {
        
        for (int x=5; x > 0; x--) {
            
            for (Haircut *h in self.haircutsArray) {
                
                if (h.rating == x) {
                    [sortedArray addObject:h];
                }
            }
        }
        ascendingRating = NO;
        
    } else {
        
        for (int x=0; x < 6; x++) {
            
            for (Haircut *h in self.haircutsArray) {
                
                if (h.rating == x) {
                    [sortedArray addObject:h];
                }
            }
        }
        ascendingRating = YES;        
    }
    
    self.haircutsArray = sortedArray;
    [self.haircutsTableView reloadData];
    
}

-(IBAction)sortByHairdresser:(id)sender {
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    NSMutableArray *hairdressersArray = [[NSMutableArray alloc] init];
    
    for (int x=0; x < [self.haircutsArray count]; x++) {
        
        BOOL nameExists = NO;
        
        Haircut *haircut = [self.haircutsArray objectAtIndex:x];
        
        NSString *hairdresserName = haircut.hairdresser.name;
        
        for (NSString *name in hairdressersArray) {
            if ([name isEqualToString:hairdresserName]) nameExists = YES;
        }
        
        if (!nameExists) {
            
            for (int y=0; y < [self.haircutsArray count]; y++) {
                
                Haircut *haircuty = [self.haircutsArray objectAtIndex:y];
                
                if ([haircuty.hairdresser.name isEqualToString:hairdresserName]) [sortedArray addObject:haircuty];
            }
            
            [hairdressersArray addObject:hairdresserName];
        }
    }
    
    self.haircutsArray = sortedArray;
    [self.haircutsTableView reloadData];
}

#pragma mark Actions.

-(void)addHairCut:(UIBarButtonItem *)barButton {
    
    HaircutViewController *haircutViewController = [[HaircutViewController alloc] initWithNibName:@"HaircutViewController" bundle:nil];
    haircutViewController.editMode = YES;
    
    [self.navigationController pushViewController:haircutViewController animated:YES];
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
    cell.companyLabel.font = [UIFont fontWithName:@"CreteRound-Regular" size:14.0f];
    
    
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", haircut.date];
    //cell.companyLabel.font = [UIFont fontWithName:@"CreteRound-Regular" size:12.0f];
    [cell.ratingImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dstar", haircut.rating]]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HaircutViewController *viewHaircut = [[HaircutViewController alloc] initWithNibName:@"HaircutViewController" bundle:nil];
    
    Haircut *haircut = [self.haircutsArray objectAtIndex:indexPath.row];
    
    viewHaircut.title = haircut.date;
    viewHaircut.haircut = haircut;
    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self.navigationController pushViewController:viewHaircut animated:YES];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
