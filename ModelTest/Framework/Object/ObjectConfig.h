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

+(id<ObjectConfigInterface>)config:(NSDictionary*)data;

-(id<ObjectConfigInterface>)initWithConfig:(NSDictionary*)data;

-(id)get:(NSString*)name;
-(id)get:(NSString*)name default:(NSString*)fallback;

-(void)set:(NSString *)name value:(id)value;

-(BOOL)has:(NSString*)name;

-(id<ObjectConfigInterface>)remove:(NSString*)name;

-(id<ObjectConfigInterface>)append:(id)config;

+(NSDictionary*)unbox:(id)data;

-(NSDictionary*)toDictionary;

+(id<ObjectConfigInterface>)fromDictionary:(NSDictionary*)dictionary;

@end


@interface ObjectConfig : NSObject <ObjectConfigInterface, NSCopying>
{
    @protected NSMutableDictionary *_data;
}

@end

