//
//  WSBoss.h
//  MessageHandling
//
//  Created by Wolfram Schroers on 4/6/12.
//  Copyright (c) 2012 Numerik & Analyse Schroers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WSEmployee;

@interface WSBoss : NSObject

// The employee (not owned by the boss).
@property (weak) WSEmployee *worker;

@end
