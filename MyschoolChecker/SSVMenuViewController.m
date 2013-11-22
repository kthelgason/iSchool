//
//  SSVMenuViewController.m
//  MyschoolChecker
//
//  Created by Björn Orri Sæmundsson on 05/11/13.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVMenuViewController.h"
#import "SSVMyschoolChecker.h"
#import "TFHpple.h"

@interface SSVMenuViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *menuView;

@end

@implementation SSVMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UITabBarItem* tab = [self tabBarItem];
        [tab setTitle:@"Málið"];
        [tab setImage:[UIImage imageNamed:@"hnifapar.png"]];
        
        UINavigationItem* u = [self navigationItem];
        [u setTitle:@"Málið"];
        
        UIBarButtonItem* refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];

        self.navigationItem.rightBarButtonItem = refreshButton;
        
        
    }
    return self;
}

- (void)refresh
{
    [self.menuView setAlpha:0.0];
    NSURL* fullUrl = [NSURL URLWithString:@"http://malid.ru.is"];
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:fullUrl];
    [self.menuView loadRequest:urlRequest];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSURL* fullUrl = [NSURL URLWithString:@"http://malid.ru.is"];
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:fullUrl];
    [self.menuView loadRequest:urlRequest];
}


/*- (void)viewWillAppear:(BOOL)animated
{
    [self.menuView setHidden:YES];
    NSURL* url = [NSURL URLWithString:@"http://malid.ru.is"];
    [self.menuView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.menuView setHidden:NO];
}*/


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Hide all unnecessary elements on the page.
    NSString* js = @"var page=document.getElementsByClassName('storycontent')[0];while(page.tagName!='body'){var sibling=page.parentNode.firstChild;for(;sibling;sibling=sibling.nextSibling){if(sibling.nodeType==1&&sibling!==page&&sibling.id != 'hd')sibling.style.display='none'}page=page.parentNode}";
    [webView stringByEvaluatingJavaScriptFromString:js];
    
    // The webView is initially clear. This is done to minimize the visibility of the javascript hiding.
    [webView setAlpha:1.0];
    
    //UIScrollView *sv = [[webView subviews] objectAtIndex:0];
    //[sv zoomToRect:CGRectMake(250, 0, 138, sv.contentSize.height) animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
