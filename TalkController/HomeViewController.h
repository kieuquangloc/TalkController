//
//  Created by zzkenjiloczz on 9/23/14.
//  Copyright (c) 2014 QuangLoc. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeViewController : UIViewController{
    __weak IBOutlet UIWebView *web;
    __weak IBOutlet UIButton *buttonGo;
}
- (IBAction)goAction:(id)sender;
- (IBAction)stopAction:(id)sender;
@property (atomic, weak) IBOutlet UITextField *textField;
- (void) loadWeb;
@end
