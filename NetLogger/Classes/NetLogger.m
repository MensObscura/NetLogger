//
//  NetLogger.m
//  NetLogger
//
//  Created by Pankaj Nathani on 08/05/18.
//

#import "NetLogger.h"
#import "NLOverlayViewController.h"

@interface NetLogger()
@property NLOverlayViewController* oVC;
@property NLWindow* window;
@end

@implementation NetLogger

+ (id)sharedManager {
    static NetLogger *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)show:(NetLoggerAlign)position
{
    if (!self.oVC)
    {
        NSBundle *bundle =[NSBundle bundleForClass:self.classForCoder];
        NSURL* podBundleURL = [bundle URLForResource:@"NetLogger" withExtension:@"bundle"];
        NSBundle* podBundle = [NSBundle bundleWithURL:podBundleURL];
        
        
        self.oVC = [[NLOverlayViewController alloc] initWithNibName:@"NLOverlayViewController" bundle:podBundle];
        self.oVC.position = position;
        
        
    }
    
    if (!self.window){
        self.window = [[NLWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.eventDelegate = self;
        self.window.rootViewController = self.oVC;
    }
    self.window.hidden = NO;
}

#pragma mark - NLWindowDelegate
- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow{
    if (self.window.rootViewController.presentedViewController == nil)
    {
     return [self.oVC shouldHandleTouchAtPoint:pointInWindow];
    }
    else if ([self.window.rootViewController.presentedViewController isKindOfClass: [NLBaseViewController class]])
    {
        return YES;
    }
    return NO;
}
@end
