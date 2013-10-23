//
//  ArticlesViewController.m
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ArticlesViewController.h"

@implementation ArticlesViewController

-(void)construct:(ObjectConfig *)config
{
    [super construct:config];
    
    [self.model setState:@{@"sort":@"title"}];
}

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{@"model_name":@"Article"}];
    
    [super initialize:config];
}


- (IBAction)sortChanged:(UISegmentedControl*)sender
{
    if(sender.selectedSegmentIndex == 1){
        [self.model setState:@{@"direction":@"DESC"}];
    }else{
        [self.model setState:@{@"direction":@"ASC"}];
    }
}

-(void)onModelStateChange:(NSString*)name
{
    [self.tableView reloadData];
}




- (IBAction)editPushed:(UIBarButtonItem*)sender
{
    if(self.tableView.isEditing){
        [self.tableView setEditing:NO animated:YES];
        sender.title = @"Edit";
    }else{
        [self.tableView setEditing:YES animated:YES];
        sender.title = @"Cancel";
    }
}

- (IBAction)unwindToArticlesView:(UIStoryboardSegue *)segue {
    //nothing goes here
}

#pragma mark UITableView data source methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = self.model.sections[section];
    return [sectionInfo numberOfObjects];
}

#pragma mark UITableView delegate methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //Attempt to assign row title/name attribute to cell text label
    id row = [self.model objectAtIndexPath:indexPath];
    cell.textLabel.text = [row title];
    
    return cell;
}

@end
