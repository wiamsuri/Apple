/*
 * SpriteBuilder: http://www.spritebuilder.org
 *
 * Copyright (c) 2012 Zynga Inc.
 * Copyright (c) 2013 Apportable Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "cocos2d.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "Item.h"
#import "CCBuilderReader.h"

@implementation AppController

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    [Parse setApplicationId:@"uqt7zwMD2ORgmSkVYcy7bE4NyfWGMTuZ1mVtOAbr"
                  clientKey:@"x1xkFz4ucchKJqSme9cPgGnLavypVeX7ZZ1Y3Z6P"];
    
    //analytics
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //parse init facebook parse happy
    [PFFacebookUtils initializeFacebook];
    
    [PFTwitterUtils initializeWithConsumerKey:@"hEWDXLxd5b2acSpRJqhiMuiFp"
                               consumerSecret:@"JmxIlnLQwXwY4dU2PlMR7BsOyyiRFlDvJdW3uv9bn2ERffCcHX"];
    
    //so ppl can see the time :)
    //[[UIApplication sharedApplication] setStatusBarHidden:false];
    
    //badge number to 0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstStartForArray"]){
        [self setupArray];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"vergin start"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self checkForNewFact];
    
    //ask for permission
    [self askForPermission];
    //set fire date
    [self setFireDate];
    
    
    [self checkIn];
    
    // Configure Cocos2d with the options set in SpriteBuilder
    NSString* configPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Published-iOS"]; // TODO: add support for Published-Android support
    configPath = [configPath stringByAppendingPathComponent:@"configCocos2d.plist"];
    
    NSMutableDictionary* cocos2dSetup = [NSMutableDictionary dictionaryWithContentsOfFile:configPath];
    
    // Note: this needs to happen before configureCCFileUtils is called, because we need apportable to correctly setup the screen scale factor.
#ifdef APPORTABLE
    if([cocos2dSetup[CCSetupScreenMode] isEqual:CCScreenModeFixed])
        [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenAspectFitEmulationMode];
    else
        [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenScaledAspectFitEmulationMode];
#endif
    
    // Configure CCFileUtils to work with SpriteBuilder
    [CCBReader configureCCFileUtils];
    
    // Do any extra configuration of Cocos2d here (the example line changes the pixel format for faster rendering, but with less colors)
    //[cocos2dSetup setObject:kEAGLColorFormatRGB565 forKey:CCConfigPixelFormat];
    
    [self setupCocos2dWithOptions:cocos2dSetup];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
    
    [[CCDirector sharedDirector] resume];
    
    [self checkForNewFact];
    
    [self checkIn];
}

- (void) checkIn{
    NSDate *now = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:now forKey:@"lastSeen"];
    //NSLog(@"setlastseen");
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) checkForNewFact{
    //IF SHOULD PRESENT NEW FACT
    NSDate * then = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSeen"];
    NSDate * now = [NSDate date];
    NSTimeInterval interval = [then timeIntervalSinceDate:now];
    //NSTimeInterval interval2 = [now timeIntervalSinceDate:then];
    //NSLog(@"%f",interval);
    //NSLog(@"%f",interval2);
    float nowtothen = interval;//this one is negative
    nowtothen = nowtothen/3600;//change to hours
    //NSLog(@"NOW TO THEN IN HOURS%f",nowtothen);
    NSCalendar * cal = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *components =
    [cal components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate: now];
    [components setHour:9];
    [components setMinute:0];
    [components setSecond:0];
    
    NSDate * ninetoday = [cal dateFromComponents:components];
    NSTimeInterval lastseenToNine = [ninetoday timeIntervalSinceDate:then];
    NSTimeInterval nowToNine = [ninetoday timeIntervalSinceDate:now];
    //NSLog(@"Lastseen SINCE 9am%f", lastseenToNine);
    //NSLog(@"Time since 9am%f", nowToNine);
    //if lastseen to nine is positive AND not to nine is negative, then we have crossed the 9o'clock
    //NSLog(@"=============================");
    //check by the last check in time @"lastSeen"
    Item * i = [[Item alloc] init];
    
    if(nowtothen <= -24.0){
        //CALL THE ITEM NEXT ITEM
        //after calling next item, change lastseen to now right away to prevent any shit from going wrong
        [i changeToNextItem];
        [self checkIn];
    }
    else{
        if(lastseenToNine > 0 && nowToNine < 0){
            [i changeToNextItem];
            [self checkIn];
        }
    }
    //ELSE DO NOTHING
    
}

- (void) setupArray{
    //NSMutableArray * newArray = [[NSMutableArray alloc] init];
    //NSDictionary * newdict = [[NSDictionary alloc] init];
    
    //NSHashTable * newhash = [[NSHashTable alloc] init];
    for(int i = 0; i < 6; i++){
        Item * hehe = [[Item alloc] init];
        int maxInsection = [hehe numItemInSec:i];
        for(int j = 0; j < maxInsection; j++){
            
            NSString * temp = [NSString stringWithFormat:@"item%i-%i", i,j];
            NSString * path = [[NSBundle mainBundle] pathForResource:temp ofType:@"plist"];
            NSDictionary * dict = [[NSDictionary alloc] initWithContentsOfFile:path];
            
            
            NSDictionary * newdict;
            //set up dict
            newdict = [[NSDictionary alloc] initWithObjectsAndKeys:[dict objectForKey:@"name"],@"name",[NSNumber numberWithInt:i],@"i-factor",[NSNumber numberWithInt:j],@"j-factor",[NSNumber numberWithBool:false], @"seen",[NSNumber numberWithBool:false], @"bookmarked",nil];
            //add to array
            //[newArray addObject:newdict];
            //NSString * temp2 = [NSString stringWithFormat:temp,@"info"];
            [[NSUserDefaults standardUserDefaults] setObject:newdict forKey:temp];
        }
    }
    
    //[[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"arrayOfItemCaller"];
    //NSLog(@"%li", (long)[newArray count]);
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"FirstStartForArray"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void) askForPermission{
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    }
}

- (void) setFireDate{
    //NSLog(@"%@",[[UIApplication sharedApplication] scheduledLocalNotifications]);
    if([UIApplication sharedApplication].scheduledLocalNotifications.count == 0 || [UIApplication sharedApplication].scheduledLocalNotifications == nil){
        //make ner notification
        //NSLog(@"make new one");
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        
        NSDateComponents *componentsForReferenceDate =
        
        [calendar components:(NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth ) fromDate:[NSDate date]];
        
        [componentsForReferenceDate setDay:1];
        [componentsForReferenceDate setMonth:1];
        [componentsForReferenceDate setYear:2014];
        
        NSDate *referenceDate = [calendar dateFromComponents:componentsForReferenceDate];
        
        NSDateComponents *componentsForFireDate =
        
        [calendar components:(NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond ) fromDate: referenceDate];
        
        [componentsForFireDate setHour: 9];
        [componentsForFireDate setMinute:0];
        [componentsForFireDate setSecond:0];
        
        NSDate *fireDateOfNotification = [calendar dateFromComponents: componentsForFireDate];
        
        // Create the notification
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        
        notification.fireDate = fireDateOfNotification;
        notification.timeZone = [NSTimeZone localTimeZone];
        notification.alertBody = [NSString stringWithFormat:@"Did you know that...?"];
        notification.alertAction = @"";
        notification.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@""] forKey:@"information"];
        notification.repeatInterval = NSCalendarUnitDay;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.applicationIconBadgeNumber = 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        //NSLog(@"%@",[[UIApplication sharedApplication] scheduledLocalNotifications]);
    }
}

- (CCScene*) startScene
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstStartpaileaw"])
        return [CCBReader loadAsScene:@"FirstStart"];
    else
        return [CCBReader loadAsScene:@"MainScene"];
}

@end
