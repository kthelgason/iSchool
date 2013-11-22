//
//  SSVDetailViewController.m
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 23.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import "SSVDetailViewController.h"
#import "SSVMyschoolChecker.h"
#import "SSVAssignment.h"

@interface SSVDetailViewController ()

@end

@implementation SSVDetailViewController

@synthesize assignment, webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableString* urlString = [NSMutableString stringWithString:@"https://myschool.ru.is/myschool/"];
    [urlString appendString:[assignment assignmentURL]];

    NSURL* fullUrl = [NSURL URLWithString:urlString];
    
    NSString* basicAuthentication = [[NSUserDefaults standardUserDefaults] stringForKey:@"Authentication"];
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:fullUrl];
    [urlRequest setValue:basicAuthentication forHTTPHeaderField:@"Authorization"];
    
    [webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"did start load");
}

- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    NSMutableString* js = [NSMutableString stringWithString:@"$('.ruHeader a').click(function(e){e.preventDefault()});$('.ruLeft').hide();$('.ruRight').hide();$('.ruFooter').hide();$('#headersearch').hide();$('.level1').hide()"];
    
    
    if(![[NSUserDefaults standardUserDefaults] valueForKey:@"Zoomed"])
    {
        [js appendString:@";$('.resetSize').click();$('.increaseSize').click();$('.increaseSize').click()"];
        [[NSUserDefaults standardUserDefaults] setObject:@"zoomed" forKey:@"Zoomed"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [theWebView stringByEvaluatingJavaScriptFromString:js];
    [theWebView setAlpha:1.0];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Loading error :(");
}

-(void)setAssignment:(SSVAssignment *)a{
    assignment = a;
    [[self navigationItem] setTitle:[assignment title]];
}


@end
