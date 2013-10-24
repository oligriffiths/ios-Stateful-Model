//
//  ModelData.m
//  ModelTest
//
//  Created by Oli Griffiths on 08/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ModelCoreData.h"
#import <CoreData/CoreData.h>

@interface ModelCoreData ()

@property (nonatomic, readwrite) DatabaseEntity *entity;

-(void)_buildRequestProperties:(NSFetchRequest*)request;
-(void)_buildRequestEntity:(NSFetchRequest*)request;
-(void)_buildRequestConditions:(NSFetchRequest*)request;
-(void)_buildRequestOrder:(NSFetchRequest*)request;
-(void)_buildRequestLimit:(NSFetchRequest*)request;

@end

@implementation ModelCoreData

-(void)construct:(ObjectConfig *)config
{
    [super construct:config];
    
    //Set the entity (table)
    if([config has:@"entity"] && [[config get:@"entity"] isKindOfClass:[DatabaseEntity class]]){
        self.entity = [config get:@"entity"];
    }
    
    [self.state insert:@"limit"     filter:@"int"       default:nil     unique:NO required:nil operator:nil];
    [self.state insert:@"offset"    filter:@"int"       default:nil     unique:NO required:nil operator:nil];
    [self.state insert:@"sort"      filter:@"cmd"       default:nil     unique:NO required:nil operator:nil];
    [self.state insert:@"direction" filter:@"word"      default:@"ASC"  unique:NO required:nil operator:nil];
    [self.state insert:@"search"    filter:@"string"    default:nil     unique:NO required:nil operator:nil];
}

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{
                     @"adapter": [NSNull null],
                     @"entity": [NSNull null],
                     @"entity_name": @""
                     }];
    
    [super initialize:config];
}

-(DatabaseEntity*)entity
{
    if(!_entity){
        _entity = [[DatabaseEntity alloc] initWithConfig:[ObjectConfig config:@{@"name": [self.config get:@"entity_name"]}]];
    }
    
    return _entity;
}

-(NSArray*)rowset
{
    if(!super.rowset)
    {
        NSFetchRequest *request = self.entity.fetchRequest;
        
        [self _buildRequestProperties:request];
        [self _buildRequestEntity:request];
        [self _buildRequestConditions:request];
        [self _buildRequestOrder:request];
        [self _buildRequestLimit:request];
        
        self.rowset = [self.entity fetch:request];
    }
    
    return super.rowset;
}

-(NSManagedObject*)row
{
    if(!super.row)
    {
        if([self.state isUnique]){
            NSFetchRequest *request = self.entity.fetchRequest;
            
            [self _buildRequestProperties:request];
            [self _buildRequestEntity:request];
            [self _buildRequestConditions:request];
            
            self.row = [[self.entity fetch:request] firstObject];
        }else{
            self.row = [self.entity getEntity];
        }
    }
    
    return super.row;
}

-(id)objectAtIndexPath:(NSIndexPath*)indexPath
{
    [self rowset];
    
    return [self.entity objectAtIndexPath:indexPath];
}

-(NSArray*)sections
{
    [self rowset];
    return self.rowset ? self.entity.sections : nil;
}

-(void)_buildRequestProperties:(NSFetchRequest*)request
{
    
}

-(void)_buildRequestEntity:(NSFetchRequest*)request
{
    
}

-(void)_buildRequestConditions:(NSFetchRequest*)request
{
    request.predicate = nil;
}

-(void)_buildRequestOrder:(NSFetchRequest*)request
{
    if([self.state has:@"sort"] && [[self.state get:@"sort"] isKindOfClass:[NSString class]] && ![[self.state get:@"sort"] isEqualToString:@""]){
        NSString *sort = [self.state get:@"sort"];
        BOOL direction = ![[[self.state get:@"direction"] uppercaseString] isEqualToString:@"DESC"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sort ascending:direction]];
    }else{
        request.sortDescriptors = @[];
    }
}

-(void)_buildRequestLimit:(NSFetchRequest*)request
{
    request.fetchLimit = [[self.state get:@"limit"] intValue];
    request.fetchOffset = 0;
}

@end
