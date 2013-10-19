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
#import "SSVGradeCell.h"
#import "SSVGrade.h"
#import "SSVMyschoolChecker.h"

@interface SSVGradesTableViewController ()

@end

@implementation SSVGradesTableViewController

- (id)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
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
    UINib* nib = [UINib nibWithNibName:@"SSVGradeCell" bundle:nil];
    
    // Register the nib that contains the cell
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"SSVGradeCell"];
    self.refreshControl = refreshControl;
}

-(void)viewDidAppear:(BOOL)animated{
    
    if(![[NSUserDefaults standardUserDefaults] stringForKey:@"Authentication"])
    {
        SSVLoginViewController* loginView = [[SSVLoginViewController alloc] init];
        [self presentViewController:loginView animated:animated completion:nil];
    }
    //otherwise load data as usual
    else
    {
        SSVDataStore* dataStore = [SSVDataStore sharedStore];
        if(dataStore.allGrades.count == 0){
            NSArray* data = [SSVMyschoolChecker fetchGrades];
            [dataStore emptyDataStoreGrades];
            [dataStore populateGrades:data];
            [self.tableView reloadData];
        }
    }
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData{
    SSVDataStore* ds =[SSVDataStore sharedStore];
    [ds emptyDataStoreGrades];
    [ds populateGrades:[SSVMyschoolChecker fetchGrades]];
    [self.tableView reloadData];
    [[self refreshControl]endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[SSVDataStore sharedStore] allGrades] objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSVGradeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SSVGradeCell"];
    
    NSArray* gradesInCourse = [[[SSVDataStore sharedStore] allGrades] objectAtIndex:[indexPath section]];
    SSVGrade* grade = [gradesInCourse objectAtIndex:[indexPath row]];
    [[cell assignmentNameLabel] setText:[grade assignmentName]];
    [[cell orderLabel] setText:[grade order]];
    [[cell gradeLabel] setText:[grade grade]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[SSVDataStore sharedStore] allGrades] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSArray* array = [[[SSVDataStore sharedStore] allGrades] objectAtIndex:section];
    if(array.count > 0){
        return [[array objectAtIndex:0] inCourse];
    }
    return @"??";
}


@end
