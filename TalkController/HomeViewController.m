//
//  Created by zzkenjiloczz on 9/19/14.
//  Copyright (c) 2014 QuangLoc. All rights reserved.
//

#import "HomeViewController.h"
@interface HomeViewController ()
@end
@implementation HomeViewController
@synthesize textField;
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"HomeVC";
    self.navigationController.navigationBarHidden = YES;
    self.textField.text = @"google.com";
    [self loadWeb];
}
- (void) loadWeb{
    NSString *string = textField.text;
    NSLog(@"%@",string);
    if ([string rangeOfString:@"http"].location == NSNotFound ) {
        NSString *string2 = [NSString stringWithFormat:@"https://%@",string];
        NSLog(@"string2 = %@",string2);
        NSURL *url = [NSURL URLWithString:string2];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [web loadRequest:request];
    }
    else{
        NSURL *url = [NSURL URLWithString:string];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [web loadRequest:request];
    }
}
- (IBAction)goAction:(id)sender {
    [self loadWeb];
}
- (IBAction)stopAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
