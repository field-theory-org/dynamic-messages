//
//  WSBoss.m
//  MessageHandling
//
//  Created by Wolfram Schroers on 4/6/12.
//  Copyright (c) 2012 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSBoss.h"
#import "WSEmployee.h"

@implementation WSBoss

@synthesize worker = _worker;

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [[WSEmployee class] instanceMethodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"%@ says: I don't do '%@' myself.",
          NSStringFromClass([self class]),
          [anInvocation description]);
    if ([self.worker respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self.worker];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

@end
