//
//  Created by zzkenjiloczz on 9/19/14.
//  Copyright (c) 2014 QuangLoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <OpenEars/OpenEarsEventsObserver.h>
#import "SecurityViewController.h"
@interface PlayVoiceViewController : UIViewController <OpenEarsEventsObserverDelegate, UITextViewDelegate>
{
    __weak IBOutlet UIButton *buttonQuit;
    __weak IBOutlet UIButton *buttonFly;
    __weak IBOutlet UIButton *buttonRestart;
    __weak IBOutlet UIImageView *sky;
    __weak IBOutlet UIImageView *sky2;
    __weak IBOutlet UIImageView *land;
    __weak IBOutlet UIImageView *land2;
    __weak IBOutlet UIImageView *tree;
    __weak IBOutlet UIImageView *tree2;
    __weak IBOutlet UIImageView *shadow;
    __weak IBOutlet UIImageView *whell;
    __weak IBOutlet UIImageView *objectText;
    __weak IBOutlet UIImageView *objectLogo;
    __weak IBOutlet UITextView *intructionGame;
    NSTimer *timer;
    NSTimer *timer2;
    NSTimer *timer3;
    NSTimer *timer4;
}
@property (nonatomic, assign) float b;
- (IBAction)flyAction:(id)sender;
- (IBAction)restartAction:(id)sender;
- (IBAction)quitAction:(id)sender;
@end
