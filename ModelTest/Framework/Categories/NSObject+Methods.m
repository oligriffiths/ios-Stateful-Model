//
//  NSObject+Methods.m
//  ModelTest
//
//  Created by Oli Griffiths on 24/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "NSObject+Methods.h"
#import <objc/runtime.h>

@implementation NSObject (Methods)

-(NSArray*)methods
{
    NSMutableArray *methods = [NSMutableArray new];
    
    Class currentClass = [self class];
    while (currentClass) {
        // Iterate over all instance methods for this class
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        unsigned int i = 0;
        for (; i < methodCount; i++) {
            [methods addObject:NSStringFromSelector(method_getName(methodList[i]))];
        }
        
        free(methodList);
        currentClass = class_getSuperclass(currentClass);
    }

    return methods;
}

@end
