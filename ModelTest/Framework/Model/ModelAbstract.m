//
//  ModelAbstract.m
//  ModelTest
//
//  Created by Oli Griffiths on 07/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ModelAbstract.h"

@implementation ModelAbstract
{
    @private
    id _state;
    NSMutableArray* _stateObservers;
}

-(void)construct:(ObjectConfig *)config
{
    [super construct:config];

    _state = [config get:@"state"];
    _stateObservers = [NSMutableArray arrayWithArray:[config get:@"observers"]];
}


-(void)initialize:(ObjectConfig *)config
{
    [config append:@{
                     @"state": [[ModelState alloc] init:[[ObjectConfig alloc] init:@{@"observers": @[self]}]],
                     @"observers":@[]
                     }];
    
    [super initialize:config];
}


-(void)addObserver:(id<ModelStateObserver>)observer
{
    [_stateObservers addObject:observer];
}

-(void)notifyObservers:(NSString*)name
{
    for(id<ModelStateObserver> observer in _stateObservers){
        if([observer respondsToSelector:@selector(onModelStateChange:)]){
            [observer performSelector:@selector(onModelStateChange:) withObject:name];
        }
    }
}


-(ModelAbstract*)reset:(BOOL)toDefaults
{
    _rowset = nil;
    _row = nil;
    _total = 0;
    
    [self.state reset:toDefaults];
    
    return self;
}

-(ModelAbstract*)setState:(NSDictionary*)values
{
    [self.state setValues:values];
    return self;
}

-(id)getState
{
    return _state;
}

-(void)onStateChange:(NSString*)name
{
    _rowset = nil;
    _row = nil;
    _total = 0;
    
    [self notifyObservers: name];
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"Rows: %@, Total: %i, Row: %@, State: %@", self.rowset, self.total, self.row, self.state];
}


@end
