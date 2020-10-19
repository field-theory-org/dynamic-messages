//
//  WSAppDelegate.m
//  MessageHandling
//
//  Created by Wolfram Schroers on 4/6/12.
//  Copyright (c) 2012 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSAppDelegate.h"
#import "WSBoss.h"
#import "WSEmployee.h"

@interface WSAppDelegate ()

// The test objects for message invocations.
@property (nonatomic, strong) WSBoss *theBoss;
@property (nonatomic, strong) WSEmployee *aWorker;

// Ask the boss to get work done.
- (void)doWork;

@end

@implementation WSAppDelegate

@synthesize window = _window;
@synthesize theBoss = _theBoss;
@synthesize aWorker = _aWorker;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.theBoss = [[WSBoss alloc] init];
    self.aWorker = [[WSEmployee alloc] init];
    
    // If the boss has no employee, the message cannot be resolved.
    self.theBoss.worker = nil;
    [self doWork];
    
    // If the boss is assigned an employee, the latter always claims to have done the work.
    self.theBoss.worker = self.aWorker;
    [self doWork];

    // Disable the warnings.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    // Completely dynamical construction of objects and messages from strings.
    id anotherBoss = [[NSClassFromString(@"WSBoss") alloc] init];
    [anotherBoss performSelector:NSSelectorFromString(@"setWorker:")
                      withObject:self.aWorker];
    [anotherBoss performSelector:NSSelectorFromString(@"anotherJob")];
#pragma clang diagnostic pop
}

- (void)doWork
{
    NSLog(@"%@ is assigning work.", NSStringFromClass([self class]));
    @try {
        // Disable compiler warnings
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.theBoss performSelector:@selector(completeWork)];
        [self.theBoss performSelector:@selector(completeWorkForMe:)
                           withObject:self];
        [self.theBoss performSelector:@selector(doMoreStuffWithMe:andMe:)
                           withObject:self
                           withObject:self];
#pragma clang diagnostic pop
    }
    @catch (NSException *exception) {
        NSLog(@"Encountered exception: %@", [exception description]);
    }
    @finally {
        NSLog(@"Finishing things up.");
    }
}

@end
