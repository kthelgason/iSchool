//
//  SSVTableViewController.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 20.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVTableViewController.h"
#import "SSVAssignment.h"
#import "SSVDataStore.h"
#import "SSVDetailViewController.h"
#import "SSVMyschoolChecker.h"
#import "SSVLoginViewController.h"
#import "SSVCell.h"

@implementation SSVTableViewController

- (id)init{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        UINavigationItem* u = [self navigationItem];
        [u setTitle:@"Assignments due"];
        
        UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Cross.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(logOut)];
        self.navigationItem.rightBarButtonItem = logOutButton;
    }
    return self;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SSVDetailViewController* detailView = [[SSVDetailViewController alloc] init];
    
    NSArray* items = [[SSVDataStore sharedStore]allAssignments];
    SSVAssignment* selected = [items objectAtIndex:[indexPath row]];
    
    [detailView setAssignment:selected];
    
    // Push detailview on the viewController stack
    [[self navigationController] pushViewController:detailView animated:YES];
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
        NSArray* data = [SSVMyschoolChecker fetchAssignments];
        SSVDataStore* dataStore = [SSVDataStore sharedStore];
        [dataStore populateData:data];
    }
    [super viewWillAppear:animated];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Create instance of UITableViewCell
    SSVCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SSVCell"];

    SSVAssignment* assignment = [[[SSVDataStore sharedStore] allAssignments] objectAtIndex:[indexPath row]];
    [[cell titleLabel] setText:[assignment title]];
    [[cell courseNameLabel] setText:[assignment courseName]];
    [[cell dueDateLabel] setText:[assignment dueDate]];
    if([assignment.handedIn  isEqual: @"Óskilað"]){
        [[cell completedImage] setImage:[assignment notDoneImage]];
    } else {
        [[cell completedImage] setImage:[assignment doneImage]];
    }
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[SSVDataStore sharedStore]allAssignments] count];
}

-(void)reloadData{
    SSVDataStore* ds =[SSVDataStore sharedStore];
    [ds emptyDataStore];
    [ds populateData:[SSVMyschoolChecker fetchAssignments]];
    [self.tableView reloadData];
    [[self refreshControl]endRefreshing];
}

-(void)logOut
{
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Authentication"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self viewWillAppear:YES];
}

// Code for table header. Trying to go without for now

//-(UIView*)headerView{
//    if(!headerView){
//        NSLog(@"loading headerview");
//        // Load headerview.xib
//        [[NSBundle mainBundle] loadNibNamed:@"headerView" owner:self options:nil];
//    }
//    
//    return headerView;
//}
//
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [self headerView];
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return [[self headerView]bounds].size.height;
//}




@end
