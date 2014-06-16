//
//  NSManagedObject+IsNew.m
//  ModelTest
//
//  Created by Oli Griffiths on 16/06/2014.
//  Copyright (c) 2014 Oli Griffiths. All rights reserved.
//

#import "NSManagedObject+IsNew.h"

@implementation NSManagedObject (IsNew)

-(BOOL)isNew
{
    NSDictionary *vals = [self committedValuesForKeys:nil];
    return [vals count] == 0;
}

@end
