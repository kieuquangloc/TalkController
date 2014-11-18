//
//  Created by zzkenjiloczz on 9/19/14.
//  Copyright (c) 2014 QuangLoc. All rights reserved.
//

#import "PlayVoiceViewController.h"
@interface PlayVoiceViewController (){
    float a;
    NSUserDefaults *game;
    BOOL *runed;
}
@end
@implementation PlayVoiceViewController
@synthesize b;
- (void) backgroundDefault{
    sky.frame = CGRectMake(0.0f, 66.0f, 320.0f, 120.0f);
    sky2.frame = CGRectMake(319.0f, 66.0f, 320.0f, 120.0f);
    land.frame = CGRectMake(0.0f, 240.0f, 320.0f, 50.0f);
    land2.frame = CGRectMake(319.0f, 240.0f, 320.0f, 50.0f);
    tree.frame = CGRectMake(0.0f, 270.0f, 320.0f, 30.0f);
    tree2.frame = CGRectMake(319.0f, 270.0f, 320.0f, 30.0f);
    whell.frame = CGRectMake(35.0f, 230.0f, 40.0f, 40.0f);
    shadow.frame = CGRectMake(40.0f, 268.0f, 30.0f, 5.0f);
    objectText.frame = CGRectMake(630.0f, 243.0f, 40.0f, 36.0f);
    objectLogo.frame = CGRectMake(850.0f, 230.0f, 30.0f, 42.0f);
    buttonRestart.hidden = YES;
    buttonQuit.hidden = YES;
    buttonFly.hidden = NO;
    intructionGame.text = @"Instruction:\nSay \"Fly\" to jump over Object. \nSay \"Back\" to back the last view";
    [intructionGame.delegate textViewShouldBeginEditing:NO];
}
- (void) skyAnimation{
    CGRect frameSky = sky.frame;
    CGRect frameSky2 = sky2.frame;
    if (frameSky.origin.x > -320.0f) {
        frameSky.origin.x = frameSky.origin.x - 1.0f;
    }
    else if (frameSky.origin.x == -320.0f){
        frameSky.origin.x = 320.0f;
    }
    if (frameSky2.origin.x > -320.0f) {
        frameSky2.origin.x = frameSky2.origin.x - 1.0f;
    }
    else if (frameSky2.origin.x == -320.0f){
        frameSky2.origin.x = 320.0f;
    }
    sky.frame = frameSky;
    sky2.frame = frameSky2;
}
-(void)landAnimation{
    CGRect frameLand = land.frame;
    CGRect frameLand2 = land2.frame;
    if (frameLand.origin.x > -320.0f) {
        frameLand.origin.x = frameLand.origin.x - 0.5f;
    }
    else if (frameLand.origin.x == -320.0f){
        frameLand.origin.x = 320.0f;
    }
    if (frameLand2.origin.x > -320.0f) {
        frameLand2.origin.x = frameLand2.origin.x - 0.5f;
    }
    else if (frameLand2.origin.x == -320.0f){
        frameLand2.origin.x = 320.0f;
    }
    land.frame = frameLand;
    land2.frame = frameLand2;
    CGRect frameobjectText = objectText.frame;
    CGRect frameobjectLogo = objectLogo.frame;
    if (frameobjectText.origin.x > -320.0f) {
        frameobjectText.origin.x = frameobjectText.origin.x - 1.0f;
        
    }
    else if (frameobjectText.origin.x == -320.0f){
        frameobjectText.origin.x = 330.0f;
    }
    if (frameobjectLogo.origin.x > -320.0f) {
        frameobjectLogo.origin.x = frameobjectLogo.origin.x - 1.0f;
    }
    else if (frameobjectLogo.origin.x == -320.0f){
        frameobjectLogo.origin.x = 360.0f + arc4random()%100 + frameobjectText.origin.x;
    }
    objectLogo.frame = frameobjectLogo;
    objectText.frame = frameobjectText;
}
-(void)treeAnimation{
    CGRect frameTree = tree.frame;
    CGRect frameTree2 = tree2.frame;
    if (frameTree.origin.x > -320.0f) {
        frameTree.origin.x = frameTree.origin.x - 1;
    }
    else if (frameTree.origin.x == -320.0f){
        frameTree.origin.x = 320.0f;
    }
    if (frameTree2.origin.x > -320.0f) {
        frameTree2.origin.x = frameTree2.origin.x - 1;
    }
    else if (frameTree2.origin.x == -320.0f){
        frameTree2.origin.x = 320.0f;
    }
    tree.frame = frameTree;
    tree2.frame = frameTree2;
}
-(void)whellAnimation{
    game = [NSUserDefaults standardUserDefaults];
    NSLog(@"So b = %f",b);
    if (b == -15.0f) {
        NSString *so_b = [game objectForKey:@"b"];
        b = [so_b floatValue];
    }
    CGRect frameWhell = whell.frame;
    frameWhell.origin.y = frameWhell.origin.y - b; // Cao bi tru di bay len, giam b de bay cham dan, khi b am thi roi                       xuong nhanh dan
    b = b - 1.5f;
    if (frameWhell.origin.y < 220.0f) {
        shadow.image = [UIImage imageNamed:@"shadow 1.png"];
    }
    else if (frameWhell.origin.y > 220.0f){
        shadow.image = [UIImage imageNamed:@"shadow 2.png"];
    }
    if (b < -15.0f) { //gioi han khong cho b giam nua, khong roi nhanh nua
        b = -15.0f;
        NSString *string = [[NSNumber numberWithFloat:b] stringValue];
        [game setValue:string forKey:@"b"];
        [game synchronize];
    }
    if (frameWhell.origin.y > 230.0f){
        frameWhell.origin.y = 230.0f;
    }
    whell.frame = frameWhell;
#pragma mark STOP GAME
    [self stopGame];
}
- (void)stopGame{
    if (CGRectIntersectsRect(whell.frame, objectText.frame) || CGRectIntersectsRect(whell.frame, objectLogo.frame)) {
        [timer invalidate];
        [timer2 invalidate];
        [timer3 invalidate];
        [timer4 invalidate];
        [whell stopAnimating];
        buttonRestart.hidden = NO;
        buttonQuit.hidden = NO;
        buttonFly.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"GAME" message:@"You Lose!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [self performSelector:@selector(dismissAlert:) withObject:alert afterDelay:2];
    }
}
-(void)dismissAlert:(UIAlertView *)alert{
    [alert dismissWithClickedButtonIndex:-1 animated:YES];
}
-(void)whellSpin{
    whell.animationImages = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"whell 14.png"],
                             [UIImage imageNamed:@"whell 13.png"],
                             [UIImage imageNamed:@"whell 12.png"],
                             [UIImage imageNamed:@"whell 11.png"],
                             [UIImage imageNamed:@"whell 10.png"],
                             [UIImage imageNamed:@"whell 9.png"],
                             [UIImage imageNamed:@"whell 8.png"],
                             [UIImage imageNamed:@"whell 7.png"],
                             [UIImage imageNamed:@"whell 6.png"],
                             [UIImage imageNamed:@"whell 5.png"],
                             [UIImage imageNamed:@"whell 4.png"],
                             [UIImage imageNamed:@"whell 3.png"],
                             [UIImage imageNamed:@"whell 2.png"],
                             [UIImage imageNamed:@"whell 1.png"]
                             , nil];
    [whell setAnimationRepeatCount:0];
    whell.animationDuration = 0.5;
    [whell startAnimating];
}
-(void)whellSpin2{
    whell.animationImages = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"whell 14.png"],
                             [UIImage imageNamed:@"whell 13.png"],
                             [UIImage imageNamed:@"whell 12.png"],
                             [UIImage imageNamed:@"whell 11.png"],
                             [UIImage imageNamed:@"whell 10.png"],
                             [UIImage imageNamed:@"whell 9.png"],
                             [UIImage imageNamed:@"whell 8.png"],
                             [UIImage imageNamed:@"whell 7.png"],
                             [UIImage imageNamed:@"whell 6.png"],
                             [UIImage imageNamed:@"whell 5.png"],
                             [UIImage imageNamed:@"whell 4.png"],
                             [UIImage imageNamed:@"whell 3.png"],
                             [UIImage imageNamed:@"whell 2.png"],
                             [UIImage imageNamed:@"whell 1.png"]
                             , nil];
    [whell setAnimationRepeatCount:0];
    whell.animationDuration = 1;
    [whell startAnimating];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"GameVC";
    [self backgroundDefault];
    [self whellSpin2];
    game = [NSUserDefaults standardUserDefaults];
    NSString *so_b = [game objectForKey:@"b"];
    b = [so_b floatValue];
    NSLog(@"So b = %f",b);
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(skyAnimation) userInfo:nil repeats:YES];
    timer2 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(landAnimation) userInfo:nil repeats:YES];
    timer3 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(treeAnimation) userInfo:nil repeats:YES];
    timer4 = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(whellAnimation) userInfo:nil repeats:YES];
}
- (IBAction)flyAction:(id)sender {
    b = 20.0f;
}
- (IBAction)restartAction:(id)sender {
    [self viewDidLoad];
}
- (IBAction)quitAction:(id)sender {
    [timer invalidate];
    [timer2 invalidate];
    [timer3 invalidate];
    [timer4 invalidate];
    [whell stopAnimating];
    [self.navigationController popViewControllerAnimated:NO];
}
@end
