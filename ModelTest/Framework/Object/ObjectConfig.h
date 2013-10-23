//
//  ObjectConfig.h
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ObjectConfig;
@protocol ObjectConfigInterface <NSObject>

+(ObjectConfig*)config:(NSDictionary*)data;

-(ObjectConfig*)initWithConfig:(NSDictionary*)data;

-(id)get:(NSString*)name;
-(id)get:(NSString*)name default:(NSString*)fallback;

-(ObjectConfig*)set:(NSString*)name value:(NSString*)value;

-(BOOL)has:(NSString*)name;

-(ObjectConfig*)remove:(NSString*)name;

-(ObjectConfig*)append:(id)config;

+(NSDictionary*)unbox:(id)data;

-(NSDictionary*)toDictionary;

+(ObjectConfig*)fromDictionary:(NSDictionary*)dictionary;

@end


@interface ObjectConfig : NSObject <ObjectConfigInterface, NSCopying>
{
    @protected NSMutableDictionary *_data;
}

@end

