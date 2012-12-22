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

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize haircutsArray;
@synthesize haircutsTableView;

#pragma mark Actions.

-(void)addHairCut:(UIBarButtonItem *)barButton {
    
    NewHaircutViewController *newHaircutViewController = [[NewHaircutViewController alloc] initWithNibName:@"NewHaircutViewController" bundle:nil];
    [self.navigationController presentViewController:newHaircutViewController animated:YES completion:^{}];
    
}


#pragma mark UITableview's Delegate & Datasource.

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [haircutsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Haircut *haircut = [haircutsArray objectAtIndex:[indexPath row]];

    cell.textLabel.text = [NSString stringWithFormat:@"%@", haircut.date];
    
    return cell;
}





#pragma mark UIViewController's.

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addHairCut:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.haircutsArray = [[DataManager sharedInstance] getAllHaircuts];
    
    NSLog(@"%@", haircutsArray);
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
