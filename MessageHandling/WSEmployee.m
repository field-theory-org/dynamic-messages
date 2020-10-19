//
//  WSEmployee.m
//  MessageHandling
//
//  Created by Wolfram Schroers on 4/6/12.
//  Copyright (c) 2012 Numerik & Analyse Schroers. All rights reserved.
//

#import "WSEmployee.h"
#import <objc/runtime.h>

@implementation WSEmployee

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    class_addMethod([self class], sel, (IMP)genericMethodIMP, "v@:");
    return YES;
}

void genericMethodIMP(id self, SEL _cmd)
{
    NSLog(@"%@ says: I finished '%@'.",
          NSStringFromClass([self class]),
          NSStringFromSelector(_cmd));
}

@end
