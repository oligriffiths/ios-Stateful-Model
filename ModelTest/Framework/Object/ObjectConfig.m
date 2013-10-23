//
//  ObjectConfig.m
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ObjectConfig.h"

@implementation ObjectConfig

+(ObjectConfig*)config:(NSDictionary*)data
{
    return [[[self class] alloc] initWithConfig: data];
}

-(id)init
{
    if(self = [super init]){
        _data = [NSMutableDictionary new];
    }
    return self;
}

-(id)initWithConfig:(NSDictionary*)data
{
    if(self = [super init]){
        _data = [NSMutableDictionary dictionaryWithDictionary:data];
    }
    return self;
}

-(id)get:(NSString*)name
{
    return [self get:name default:nil];
}

-(id)get:(NSString*)name default:(NSString*)fallback
{
    return [self has:name] ? _data[name] : fallback;
}

-(ObjectConfig*)set:(NSString*)name value:(NSString*)value
{
    _data[name] = value;
    return self;
}

-(BOOL)has:(NSString*)name
{
    return _data[name] != nil ? YES : NO;
}

-(ObjectConfig*)remove:(NSString*)name
{
    [_data removeObjectForKey:name];
    return self;
}

-(ObjectConfig*)append:(id) config
{
    NSDictionary *data = [ObjectConfig unbox: config];
    
    if([data isKindOfClass:[NSDictionary class]]){
        
        for(NSString *key in data){
            
            id value = data[key];
            if([self has:key]){
                
                if(![value isKindOfClass:[NSNull class]] && [_data[key] isKindOfClass:[ObjectConfig class]]){
                    _data[key] = [((ObjectConfig*) _data[key]) append:value];
                }
            }else{
                _data[key] = value;
            }
        }
    }
    
    return self;
}

+(NSDictionary*)unbox:(id) data
{
    return [data isKindOfClass:[ObjectConfig class]] ? [data toDictionary] : data;
}

-(NSDictionary*)toDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    for(NSString *key in _data){
        id value = _data[key];
        
        if([value isKindOfClass:[ObjectConfig class]]){
            dictionary[key] = [((ObjectConfig*) value) toDictionary];
        }else{
            dictionary[key] = value;
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

+(ObjectConfig*)fromDictionary:(NSDictionary*) dictionary
{
    return [[[self class] alloc] initWithConfig:dictionary];
}

#pragma mark NSCopying protocol methods
- (id)copyWithZone:(NSZone *)zone
{
    return [[self class] fromDictionary:_data];
}

@end
