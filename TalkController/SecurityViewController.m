//
//  Created by zzkenjiloczz on 9/23/14.
//  Copyright (c) 2014 QuangLoc. All rights reserved.
//

#import "SecurityViewController.h"
@interface SecurityViewController ()
{
    float x;
    float y;
    float x2;
    float y2;
    CGRect frameImageIn;
    CGRect frameImageOut;
}
@end

@implementation SecurityViewController
@synthesize fliteController;
@synthesize slt;

- (FliteController *)fliteController {
    if (fliteController == nil) {
        fliteController = [[FliteController alloc] init];
    }
    return fliteController;
}

- (Slt *)slt {
    if (slt == nil) {
        slt = [[Slt alloc] init];
    }
    return slt;
}

- (OpenEarsEventsObserver *)createOpenEarsEventsObserver {
    if (_openEarsEventsObserver == nil) {
        _openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
    }
    return _openEarsEventsObserver;
}

- (PocketsphinxController *)pocketsphinxController {
    if (_pocketsphinxController == nil) {
        _pocketsphinxController = [[PocketsphinxController alloc] init];
    }
    return _pocketsphinxController;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"CHAY VIEW DID LOAD");
    self.title = @"SecurityVC";
    [self instructionText];
    [self setImageDefault];
    instruction.delegate = self;
    
    [self.createOpenEarsEventsObserver setDelegate:self]; //them de UY QUYEN cho class nay la noi thuc thi cac method khai bao trong protoccol OpenEarsEventsObserver
    self.usingStartLanguageModel = TRUE;
    
    LanguageModelGenerator *lmGenerator = [[LanguageModelGenerator alloc]init];
    NSArray *arrayFirst = [NSArray arrayWithObjects:@"GOOGLE",@"BACK", @"GAME",nil];
    NSError *err = [lmGenerator generateLanguageModelFromArray:arrayFirst withFilesNamed:@"LanguageModelSecurity" forAcousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"]];
    NSDictionary *dictionarySecurity = nil;
    self.lmPathSecurity = nil;
    self.dicPathSecurity = nil;
    if([err code] == noErr) {
        dictionarySecurity = [err userInfo];
        NSString *lmPath = [dictionarySecurity objectForKey:@"LMPath"];
        NSString *dicPath = [dictionarySecurity objectForKey:@"DictionaryPath"];
        self.lmPathSecurity = lmPath;
        self.dicPathSecurity = dicPath;
    }
    else {
        NSLog(@"Error: %@",[err localizedDescription]);
    }
#pragma mark LANGUAGE MODEL GAME
    NSArray *arrayGame = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects: @"FLY",nil]];
    err = [lmGenerator generateLanguageModelFromArray:arrayGame withFilesNamed:@"LanguageModelGame" forAcousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"]];
    NSDictionary *dictionaryGame = nil;
    if([err code] != noErr) {
        NSLog(@"Dynamic language generator reported error %@", [err description]);
    }
    else {
        dictionaryGame = [err userInfo];
        NSString *lmPath = [dictionaryGame objectForKey:@"LMPath"];
        NSString *dicPath = [dictionaryGame objectForKey:@"DictionaryPath"];
        self.lmPathGame = lmPath;
        self.dicPathGame = dicPath;
    }
#pragma mark LANGUAGE MODEL WEB
    NSArray *arrayHome = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:@"BACK",nil]];
    err = [lmGenerator generateLanguageModelFromArray:arrayHome withFilesNamed:@"LanguageModelHome" forAcousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"]];
    NSDictionary *dictionaryHome = nil;
    if([err code] != noErr) {
        NSLog(@"Dynamic language generator reported error %@", [err description]);
    }
    else {
        dictionaryHome = [err userInfo];
        NSString *lmPath = [dictionaryHome objectForKey:@"LMPath"];
        NSString *dicPath = [dictionaryHome objectForKey:@"DictionaryPath"];
        self.lmPathHome = lmPath;
        self.dicPathHome = dicPath;
    }
    [self startListening];
    [self startDisplayingLevels];
    [self.fliteController say:@"Talk controller is ready" withVoice:self.slt];
}

- (void) startListening{
    [self.pocketsphinxController startListeningWithLanguageModelAtPath:self.lmPathSecurity dictionaryAtPath:self.dicPathSecurity acousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:NO];
}

-(void)instructionText{
    instruction.text = @"Instruction:\n- Say: GOOGLE to go Web View\n- Say: GAME to go to Game View\n- Say: BACK to go to last View";
}
# pragma mark THUC HIEN LENH
- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    NSLog(@"Heard: %@",hypothesis);
    if ([hypothesis isEqualToString:@"GOOGLE"]) {
        [self.pocketsphinxController changeLanguageModelToFile:self.lmPathHome withDictionary:self.dicPathHome];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        HomeViewController *HomeVC = (HomeViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"HomeVC"];
        HomeVC.title = @"HomeVC";
        NSString *nameCurrentVC = self.navigationController.visibleViewController.title;
        NSLog(@"nameCurrentVC: %@",nameCurrentVC);
        if (nameCurrentVC != HomeVC.title) {
            [app.nav pushViewController:HomeVC animated:YES];
        }
    }
    if ([hypothesis isEqualToString:@"GAME"]){
        [self.pocketsphinxController changeLanguageModelToFile:self.lmPathGame withDictionary:self.dicPathGame];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        PlayVoiceViewController *HomeVC = (PlayVoiceViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"PlayVC"];
        [app.nav pushViewController:HomeVC animated:YES];
    }
    
    if ([hypothesis isEqualToString:@"BACK"]){
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        [app.nav popViewControllerAnimated:YES];
        NSString *nameSeccurityView = @"SecurityVC";
        NSString *nameGameView = @"GameVC";
        NSString *nameHomeView = @"HomeVC";
        NSString *nameCurrentVC = self.navigationController.visibleViewController.title;
        NSLog(@"nameCurrentVC: %@",nameCurrentVC);
        
        if (nameCurrentVC == nameSeccurityView) {
        [self.pocketsphinxController changeLanguageModelToFile:self.lmPathSecurity withDictionary:self.dicPathSecurity];
        }
        else if (nameCurrentVC == nameGameView) {
            [self.pocketsphinxController changeLanguageModelToFile:self.lmPathGame withDictionary:self.dicPathGame];
        }
        else if (nameCurrentVC == nameHomeView) {
            [self.pocketsphinxController changeLanguageModelToFile:self.lmPathHome withDictionary:self.dicPathHome];
        }
    }
    if ([hypothesis isEqualToString:@"FLY"]){
        
        NSString *b = @"20.0f";
        game = [NSUserDefaults standardUserDefaults];
        [game setValue:b forKey:@"b"];
        [game synchronize];
        NSString *c = [game objectForKey:@"b"];
        NSLog(@"c = %@",c);
    }
}

- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
    
    NSLog(@"Pocketsphinx SU DUNG language model: \n%@ and the following dictionary: %@",newLanguageModelPathAsString,newDictionaryPathAsString);
}

- (void) startDisplayingLevels {
    [self stopDisplayingLevels];
    uiUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1/2 target:self selector:@selector(updateLevelsUI) userInfo:nil repeats:YES];
}

- (void) stopDisplayingLevels {
    if(uiUpdateTimer && [uiUpdateTimer isValid]) {
        [uiUpdateTimer invalidate];
        uiUpdateTimer = nil;
    }
}
- (void) setImageDefault
{
    imageIn.frame = CGRectMake(80.0f, 135.0f, 80.0f, 10.0f);
    imageOut.frame = CGRectMake(80.0f, 160.0f, 80.0f, 10.0f);
}
- (void) updateLevelsUI {
    indexIn.text = [NSString stringWithFormat:@"%.2f",[self.pocketsphinxController pocketsphinxInputLevel]];
    indexOut.text = [NSString stringWithFormat:@"%.2f",[self.fliteController fliteOutputLevel]];
    x = self.pocketsphinxController.pocketsphinxInputLevel;
    y = (x-(int)x+1)*30;
    frameImageIn = imageIn.frame;
    frameImageIn.size.width = frameImageIn.size.width + y;
    if (frameImageIn.size.width > 120.0f) {
        frameImageIn.size.width = 80.0f;
    }
    
    imageIn.frame = frameImageIn;
    if(self.fliteController.speechInProgress == TRUE) {
        x2 = self.fliteController.fliteOutputLevel;
        y2 = (x2-(int)x2+1)*60;
        
        frameImageOut = imageOut.frame;
        frameImageOut.size.width = frameImageOut.size.width + y2;
        if (frameImageOut.size.width > 120.0f) {
            frameImageOut.size.width = 80.0f;
        }
        imageOut.frame = frameImageOut;
    }
}

//MOT SO METHOD OPENEARS EVENTS OBSERVER

-(void) audioSessionInterruptionDidBegin {
    NSLog(@"AudioSession interruption began."); // Log it.
    statusLabel.text = @"AudioSession interruption began."; // Show it in the status box.
    [self.pocketsphinxController stopListening];
}
- (void) audioSessionInterruptionDidEnd {
    NSLog(@"AudioSession interruption ended."); // Log it.
    statusLabel.text = @"AudioSession interruption ended."; // Show it in the status box.
    [self startListening];
    
}
- (void) audioInputDidBecomeUnavailable {
    NSLog(@"The audio input has become unavailable"); // Log it.
    statusLabel.text = @"The audio input has become unavailable"; // Show it in the status box.
    [self.pocketsphinxController stopListening];
}
- (void) audioInputDidBecomeAvailable {
    NSLog(@"The audio input is available"); // Log it.
    statusLabel.text = @"The audio input is available"; // Show it in the status box.
    [self startListening];
}
- (void) audioRouteDidChangeToRoute:(NSString *)newRoute {
    NSLog(@"Audio route change. The new audio route is %@", newRoute); // Log it.
    statusLabel.text = [NSString stringWithFormat:@"Audio route change. The new audio route is %@",newRoute]; // Show it in the status box.
    [self.pocketsphinxController stopListening];
    [self startListening];
}

- (void) pocketsphinxDidStartCalibration {
    NSLog(@"Pocketsphinx calibration has started."); // Log it.
    statusLabel.text = @"Pocketsphinx calibration has started."; // Show it in the status box.
}

- (void) pocketsphinxDidCompleteCalibration {
    NSLog(@"Pocketsphinx calibration is complete."); // Log it.
    statusLabel.text = @"Pocketsphinx is Listening!"; // Show it in the status box.

    
}
- (void) pocketsphinxRecognitionLoopDidStart {
    NSLog(@"Pocketsphinx is starting up."); // Log it.
    statusLabel.text = @"Pocketsphinx is starting up."; // Show it in the status box.
}

- (void) pocketsphinxDidStartListening {
    NSLog(@"Pocketsphinx is now listening."); // Log it.
}

- (void) pocketsphinxDidDetectSpeech {
    //NSLog(@"Pocketsphinx has detected speech."); // Log it.
    statusLabel.text = @"Pocketsphinx has detected speech."; // Show it in the status box.
}

- (void) pocketsphinxDidDetectFinishedSpeech {
    //NSLog(@"Pocketsphinx has detected a second of silence, concluding an utterance."); // Log it.
    statusLabel.text = @"Pocketsphinx has detected finished speech."; // Show it in the status box.
}

- (void) pocketsphinxDidStopListening {
    //NSLog(@"Pocketsphinx has stopped listening."); // Log it.
    statusLabel.text = @"Pocketsphinx has stopped listening."; // Show it in the status box.
}
- (void) pocketsphinxDidSuspendRecognition {
    //NSLog(@"Pocketsphinx has suspended recognition."); // Log it.
    statusLabel.text = @"Pocketsphinx has suspended recognition."; // Show it in the status box.
}
- (void) pocketsphinxDidResumeRecognition {
   // NSLog(@"Pocketsphinx has resumed recognition."); // Log it.
    statusLabel.text = @"Pocketsphinx has resumed recognition."; // Show it in the status box.
}
- (void) fliteDidStartSpeaking {
    //NSLog(@"Flite has started speaking"); // Log it.
    //statusLabel.text = @"Flite has started speaking."; // Show it in the status box.
}
- (void) fliteDidFinishSpeaking {
    //NSLog(@"Flite has finished speaking"); // Log it.
   // statusLabel.text = @"Flite has finished speaking."; // Show it in the status box.
}

- (void) pocketSphinxContinuousSetupDidFail { // This can let you know that something went wrong with the recognition loop startup. Turn on [OpenEarsLogging startOpenEarsLogging] to learn why.
    NSLog(@"Setting up the continuous recognition loop has failed for some reason, please turn on [OpenEarsLogging startOpenEarsLogging] in OpenEarsConfig.h to learn more."); // Log it.
    statusLabel.text = @"Not possible to start recognition loop."; // Show it in the status box.
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{

}
@end
