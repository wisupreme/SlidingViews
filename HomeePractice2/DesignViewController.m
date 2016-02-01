//
//  ShopViewController.m
//  HomeePractice2
//
//  Created by Jake Choi on 1/29/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import "DesignViewController.h"

@interface DesignViewController ()

@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic) NSInteger myPosition;


@end

@implementation DesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeViewElements];
}


- (void) initializeViewElements{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*self.myPosition, 0, self.view.bounds.size.width, self.view.bounds.size.height-120)];
    
    self.view = view;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.imageView =  [[UIImageView alloc] initWithFrame:CGRectMake(90, 75, 200, 200)];
    
    self.imageView.image =  [UIImage imageNamed: @"defaultIcon.png"];
    
    [self.view addSubview:self.imageView];
}

- (id)initWithPosition:(NSInteger)position text:(NSString*)text
{
    if (self = [super init]) {
        self.myPosition = position;
        
    }
    return self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end