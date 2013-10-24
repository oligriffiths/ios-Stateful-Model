//
//  NSManagedObject+Data.m
//  ModelTest
//
//  Created by Oli Griffiths on 23/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "NSManagedObject+Data.h"
#import <objc/runtime.h>

@implementation NSManagedObject (Data)

-(NSDictionary*)data
{
    NSEntityDescription* entity = [NSEntityDescription entityForName:self.entity.name inManagedObjectContext:self.managedObjectContext];
    
    NSDictionary* properties = entity.propertiesByName;
    NSMutableDictionary *props = [NSMutableDictionary new];
    
    for(NSString *prop in properties)
    {
        if([properties[prop] isKindOfClass:[NSAttributeDescription class]]){
            
            id value;
            SEL selector = NSSelectorFromString(prop);
            if([self respondsToSelector:selector]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                value = [self performSelector:selector];
#pragma clang diagnostic pop
            }else{
                value = [self valueForKey:prop];
            }
            
            if(value != nil) [props setObject:value forKey:prop];
        }
    }
    
    return props;
}

-(void)setData:(NSDictionary*)data
{
    for(NSString *key in data){
        SEL selector = NSSelectorFromString([@"set" stringByAppendingFormat:@"%@:", [key uppercaseFirst]]);
        if([self respondsToSelector:selector]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:data[key]];
#pragma clang diagnostic pop
        }else{
            [self setValue:data[key] forKey:key];
        }
    }
}


-(BOOL)isNew
{
    return self.objectID.isTemporaryID;
}


-(BOOL)save
{
    NSError *error;
    
    [self.managedObjectContext save:&error];
    
    objc_setAssociatedObject(self, @"ContextError", error, OBJC_ASSOCIATION_RETAIN);
    
    return error ? NO : YES;
}

-(BOOL)delete
{
    [self.managedObjectContext deleteObject:self];
    
    NSError *error;
    
    [self.managedObjectContext save:&error];
    
    objc_setAssociatedObject(self, @"ContextError", error, OBJC_ASSOCIATION_RETAIN);
    
    return error ? NO : YES;
}

-(NSError*)error
{
    return objc_getAssociatedObject(self, @"ContextError");
}

@end
