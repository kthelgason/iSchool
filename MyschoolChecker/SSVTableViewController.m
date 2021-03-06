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
#import "SSVCustomURLProtocol.h"
#import "SSVRestartViewController.h"

dispatch_queue_t backgroundQueue;

@implementation SSVTableViewController

- (id)init{
    return [self initWithNibName:nil bundle:nil];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        UINavigationItem* u = [self navigationItem];
        [u setTitle:@"Assignments due"];
        UITabBarItem* tabItem = [self tabBarItem];
        [tabItem setTitle:@"Assignments"];
        [tabItem setImage:[UIImage imageNamed:@"Files.png"]];
        
        UIBarButtonItem *logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(didClickLogOutButton)];
        self.navigationItem.rightBarButtonItem = logOutButton;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"Authentication"] && [[[SSVDataStore sharedStore] allGrades] count] == 0){
        backgroundQueue = dispatch_queue_create("is.sigsegv.ischool.bg", NULL);
        [self process];
    }
    
    // Deselect any selected cell (for when the detail view gets popped off).
    NSIndexPath* selection = [self.tableView indexPathForSelectedRow];
	if (selection)
    {
		[self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
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
    
    // Remove empty cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Register the nib that contains the cell
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"SSVCell"];
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
        if(dataStore.allAssignments.count == 0){
            NSArray* data = [SSVMyschoolChecker fetchAssignments];
            NSLog(@"data was nil");
            [dataStore emptyDataStoreAssignments];
            [dataStore populateAssignments:data];
            [self.tableView reloadData];
        }
    }
    [super viewDidAppear:animated];
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
    [ds emptyDataStoreAssignments];
    [ds populateAssignments:[SSVMyschoolChecker fetchAssignments]];
    [self.tableView reloadData];
    [[self refreshControl]endRefreshing];
}

-(void)didClickLogOutButton
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Log Out" message:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}


-(void)logOut
{
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Authentication"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    SSVRestartViewController* restartScreen = [[SSVRestartViewController alloc] init];
    [self presentViewController:restartScreen animated:YES completion:nil];
}

// This method dispatches calls to populate the datastores asynchronously as soon as the app starts
- (void)process {
    dispatch_async(backgroundQueue, ^(void) {
        SSVDataStore* store = [SSVDataStore sharedStore];
        [store emptyDataStoreGrades];
        [store populateGrades:[SSVMyschoolChecker fetchGrades]];
    });
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self logOut];
    }
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
