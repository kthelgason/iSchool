//
//  SSVDetailViewController.h
//  MyschoolChecker
//
//  Created by Kári Tristan Helgason on 23.9.2013.
//  Copyright (c) 2013 Kári Tristan Helgason. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSVAssignment;

@interface SSVDetailViewController : UIViewController <UIWebViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(strong, nonatomic)SSVAssignment* assignment;

@end
