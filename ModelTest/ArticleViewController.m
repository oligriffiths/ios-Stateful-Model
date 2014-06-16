//
//  ArticleViewController.m
//  ModelTest
//
//  Created by Oli Griffiths on 23/10/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "ArticleViewController.h"

@implementation ArticleViewController

-(void)initialize:(ObjectConfig *)config
{
    [config append:@{@"model_name":@"Article"}];
    
    [super initialize:config];
}

-(void)viewDidLoad
{
    if(self.model.row){
        UIBarButtonItem *button = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                        target:self
                                                        action:@selector(savePushed:)];
        
        [[self navigationItem] setRightBarButtonItem:button];
    }
    
    UIButton *touch = [UIButton buttonWithType:UIButtonTypeCustom];
    [touch addTarget:self action:@selector(dismissKayboard) forControlEvents:UIControlEventTouchUpInside];
    touch.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    touch.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    touch.backgroundColor = [UIColor clearColor];
    [self.view addSubview:touch];
    [self.view sendSubviewToBack:touch];
    
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
    if(!self.model.row.isNew){
        ((UINavigationBar*)bar).hidden = YES;
        return UIBarPositionAny;
    }else{
        return UIBarPositionTopAttached;
    }
}

-(void)dismissKayboard
{
    for(UIView *view in self.view.subviews){
        [view resignFirstResponder];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.titleTextField.text = ((Article*) self.model.row).title;
    self.summaryTextView.text = ((Article*) self.model.row).summary;
}

- (IBAction)savePushed:(id)sender
{
    if(!self.model.row.isNew){
        [self edit:@{@"title":self.titleTextField.text, @"summary": self.summaryTextView.text}];
        [self.summaryTextView resignFirstResponder];
    }else{
        [self add:@{@"title":self.titleTextField.text, @"summary": self.summaryTextView.text}];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
