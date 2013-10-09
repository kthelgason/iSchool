//
//  SSVGradesTableViewController.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 2.10.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVGradesTableViewController.h"
#import "SSVLoginViewController.h"
#import "SSVDataStore.h"
#import "SSVCell.h"
#import "SSVGrade.h"
#import "SSVMyschoolChecker.h"

@interface SSVGradesTableViewController ()

@end

@implementation SSVGradesTableViewController

- (id)init{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem* u = [self navigationItem];
        [u setTitle:@"Grades Achieved"];
        UITabBarItem* tabItem = [self tabBarItem];
        [tabItem setTitle:@"Grades"];
        [tabItem setImage:[UIImage imageNamed:@"Favorites.png"]];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    UINib* nib = [UINib nibWithNibName:@"SSVCell" bundle:nil];
    
    // Register the nib that contains the cell
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"SSVCell"];
    self.refreshControl = refreshControl;
}

-(void)viewWillAppear:(BOOL)animated{
    
    if(![[NSUserDefaults standardUserDefaults] stringForKey:@"Authentication"])
    {
        SSVLoginViewController* loginView = [[SSVLoginViewController alloc] init];
        [self presentViewController:loginView animated:animated completion:nil];
    }
    //otherwise load data as usual
    else
    {
        NSArray* data = [SSVMyschoolChecker fetchGrades];
        SSVDataStore* dataStore = [SSVDataStore sharedStore];
        [dataStore populateGrades:data];
    }
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[SSVDataStore sharedStore] allGrades] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSVCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SSVCell"];
    
    SSVGrade* grade = [[[SSVDataStore sharedStore] allGrades] objectAtIndex:[indexPath row]];
    [[cell titleLabel] setText:[grade assignmentName]];
    [[cell courseNameLabel] setText:[grade order]];
    [[cell dueDateLabel] setText:[grade grade]];
    
    return cell;
}


@end
