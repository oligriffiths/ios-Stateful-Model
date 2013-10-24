//
//  NSManagedObject+Data.h
//  ModelTest
//
//  Created by Oli Griffiths on 23/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Data)

-(NSDictionary*)data;
-(void)setData:(NSDictionary*)data;

-(BOOL)isNew;

-(BOOL)save;

-(BOOL)delete;

-(NSError*)error;

@end
