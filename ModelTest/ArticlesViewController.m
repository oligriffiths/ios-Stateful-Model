//
//  ArticlesViewController.m
//  ModelTest
//
//  Created by Oli Griffiths on 22/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticleViewController.h"

@implementation ArticlesViewController
{
    BOOL _hidden;
}

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


-(void)viewWillDisappear:(BOOL)animated
{
    _hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    if(_hidden){
        _hidden = NO;
        [self.model resetData];
        [self.tableView reloadData];
    }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    if([segue.identifier isEqualToString:@"articlesToArticle"]){
        ArticleViewController *viewController = (ArticleViewController*)segue.destinationViewController;        
        viewController.model.row = [self.model objectAtIndexPath:[self.tableView indexPathForCell:sender]];
    }
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

//Delete method
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self delete:@{@"object": [self.model objectAtIndexPath:indexPath]}];
                    
        [self.model resetData];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
