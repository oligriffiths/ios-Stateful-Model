//
//  ModelState.m
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ModelState.h"

@implementation ModelStateValue
@end

@interface ModelState ()

-(BOOL)_validate:(ModelStateValue*)state;

@end

@implementation ModelState
{
    NSMutableArray *_observers;
}

-(void)construct:(ObjectConfig *)config
{
    [super construct:config];
    
    _observers = [[NSMutableArray alloc] initWithArray:[config get:@"observers"]];
}

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{
                     @"observers": @[]
                     }];
    
    [super initialize:config];
}


-(void)addObserver:(id<StateObserver>)observer
{
    [_observers addObject:observer];
}

-(void)notifyObservers:(NSString*)name
{
    for(id<StateObserver> observer in _observers){
        if([observer respondsToSelector:@selector(onStateChange:)]){
            [observer performSelector:@selector(onStateChange:) withObject:name];
        }
    }
}

-(ModelState*)insert:(NSString*)name filter:(id)filter default:(id)fallback unique:(BOOL)unique
{
    return [self insert:name filter:filter default:fallback unique:unique required:nil operator:nil];
}

-(ModelState*)insert:(NSString*)name filter:(id)filter default:(id)fallback unique:(BOOL)unique required:(NSArray*)required operator:(NSString*)operator
{
    ModelStateValue *state = [ModelStateValue new];
    
    state.name = name;
    state.filter = filter;
    state.fallback = fallback;
    state.unique = unique;
    state.required = required;
    state.operator = operator;
    
    _data[name] = state;
    
    //Set default value
    if(fallback != nil){
        [self setValue:fallback forState:name];
    }
    
    return self;
}

-(id)get:(NSString*)name
{
    return [self get:name default:nil];
}

-(id)get:(NSString*)name default:(NSString*)fallback
{
    return [self has:name] ? ((ModelStateValue*) _data[name]).value : fallback;
}

-(ModelState*)setValue:(NSString*)value forState:(NSString*)name
{
    if([self has:name] && [self get:name] != value){
        ((ModelStateValue*) _data[name]).value = value;
        
        [self notifyObservers:name];
    }
    return self;
}

-(BOOL)has:(NSString*)name
{
    return _data[name] != nil ? YES : NO;
}

-(ModelState*)remove:(NSString*)name
{
    [_data removeObjectForKey:name];
    return self;
}

-(ModelState*)reset
{
    return [self reset: YES];
}

-(ModelState*)reset:(BOOL)toDefaults
{
    for(NSString *key in _data){
        
        ModelStateValue *state = _data[key];
        state.value = toDefaults ? state.fallback : nil;
        
        [self notifyObservers:key];
    }
    return self;
}

-(ModelState*)setValues:(NSDictionary*)values
{
    for(NSString* name in values){
        [self setValue:values[name] forState:name];
    }
    
    return self;
}

-(NSDictionary*)values
{
    return [self values:NO];
}

-(NSDictionary*)values:(BOOL)unique
{
    NSMutableDictionary *data = [NSMutableDictionary new];
    
    for(NSString *key in _data)
    {
        ModelStateValue *state = (ModelStateValue*) _data[key];
        if(state.value != nil && ![state.value isEqual:[NSNull null]])
        {
            if(unique)
            {
                if(state.unique && [self _validate:state])
                {
                    BOOL result = YES;
                    
                    for(NSString *required in state.required)
                    {
                        if(![self _validate:_data[required]]){
                            result = NO;
                            break;
                        }
                    }
                    
                    if(result)
                    {
                        data[key] = state.value;
                        
                        for(NSString *required in state.required){
                            data[required] = ((ModelStateValue*)_data[required]).value;
                        }
                    }
                }
            }else{
                data[key] = state.value;
            }
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:data];
}

-(BOOL)isUnique
{
    NSDictionary *states = self.values;
    BOOL unique = NO;
    
    if(states.count){
        unique = YES;
        
        for(NSString *name in states)
        {
            id state = states[name];
            if(([state isKindOfClass:[NSDictionary class]] || [state isKindOfClass:[NSArray class]]) && ((NSArray*) state).count > 0){
                unique = NO;
                break;
            }
        }
    }
    
    return unique;
}

-(BOOL)isEmpty
{
    return [self isEmpty: nil];
}

-(BOOL)isEmpty: (NSArray*) excludes
{
    NSMutableDictionary *states = [NSMutableDictionary dictionaryWithDictionary:self.values];
    
    if(excludes && excludes.count){
        
        for(NSString *exclude in excludes)
        {
            [states removeObjectForKey:exclude];
        }
    }
    
    return states.count == 0;
}

-(BOOL)_validate:(ModelStateValue*)state
{
    if(([state.value isKindOfClass:[NSString class]] && [((NSString*)state.value) isEqualToString:@""]) ||
       ([state.value isKindOfClass:[NSArray class]] && !((NSArray*)state.value).count) ||
       ([state.value isKindOfClass:[NSDictionary class]] && !((NSDictionary*)state.value).count)){
        return NO;
    }
    
    if([state.value isKindOfClass:[NSArray class]]){
        id first = ((NSArray*) state.value)[0];
        
        if([first isKindOfClass:[NSString class]] && [((NSString*)first) isEqualToString:@""]){
            return NO;
        }
    }
    
    return YES;
}


-(NSString*)description
{
    return [NSString stringWithFormat:@"%@",self.values];
}

@end
