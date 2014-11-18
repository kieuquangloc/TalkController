//
//  Created by zzkenjiloczz on 9/19/14.
//  Copyright (c) 2014 QuangLoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "PlayVoiceViewController.h"

//import for OpenEars
#import "OpenEars/LanguageModelGenerator.h" //Generator
#import <OpenEars/PocketsphinxController.h> //Poccketsphinx
#import <OpenEars/AcousticModel.h>
#import <OpenEars/OpenEarsEventsObserver.h>
#import <Slt/Slt.h>
#import <OpenEars/FliteController.h>


@interface SecurityViewController : UIViewController <OpenEarsEventsObserverDelegate, UITextViewDelegate>
{
    NSUserDefaults *passWordUser;
    NSUserDefaults *game;
    UIAlertView *alertHello;
    UIAlertView *alertPass;
    NSTimer *uiUpdateTimer;
    __weak IBOutlet UIImageView *imageIn;
    __weak IBOutlet UIImageView *imageOut;
    __weak IBOutlet UILabel *indexIn;
    __weak IBOutlet UILabel *indexOut;
    __weak IBOutlet UILabel *statusLabel;
    __weak IBOutlet UITextView *instruction;
}
@property (nonatomic,strong)PocketsphinxController *pocketsphinxController;
@property (nonatomic,strong)OpenEarsEventsObserver *openEarsEventsObserver;
@property (nonatomic,strong)FliteController *fliteController;
@property (nonatomic,strong)Slt *slt;
@property (nonatomic, copy) NSString *lmFlieSecurity;
@property (nonatomic, copy) NSString *dicFileSecurity;
@property (nonatomic, copy) NSString *lmPathSecurity;
@property (nonatomic, copy) NSString *dicPathSecurity;
@property (nonatomic, copy) NSString *lmFlieGame;
@property (nonatomic, copy) NSString *dicFileGame;
@property (nonatomic, copy) NSString *lmPathGame;
@property (nonatomic, copy) NSString *dicPathGame;
@property (nonatomic, copy) NSString *lmFlieHome;
@property (nonatomic, copy) NSString *dicFileHome;
@property (nonatomic, copy) NSString *lmPathHome;
@property (nonatomic, copy) NSString *dicPathHome;
@property (nonatomic, assign) BOOL usingStartLanguageModel;
@end
