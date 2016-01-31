//
//  ChatTableViewController.m
//  HomeePractice2
//
//  Created by Jake Choi on 1/29/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import "ChatTableViewController.h"
#import "RoomCell.h"
@interface ChatTableViewController ()

@property (nonatomic) NSInteger myPosition;

@end

@implementation ChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeTableView];
}

- (void) initializeTableView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(320*self.myPosition, 0, 320, 460)];
    self.view = view;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}

- (id)initWithPosition:(NSInteger)position text:(NSString*)text
{
    if (self = [super init]) {
        self.myPosition = position;
  
    }
    return self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

   return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {\
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @"LOL";
    
    return cell;
}


@end
