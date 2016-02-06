//
//  ContainerViewController.m
//  HomeePractice2
//
//  Created by Jake Choi on 1/29/16.
//  Copyright © 2016 solechang. All rights reserved.
//

#import "ContainerViewController.h"
#import "ChatTableViewController.h"
#import "ShopTableViewController.h"
#import "DesignViewController.h"

@interface ContainerViewController ()

@property (nonatomic, retain) ChatTableViewController *chatTVC;
@property (nonatomic, retain) DesignViewController *designVC;
@property (nonatomic, retain) ShopTableViewController *shopTVC;

@property (nonatomic) UISegmentedControl* segmentedControl;


@property (nonatomic) UIView *sliderView;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic) UIView *slideButtonView;

@property (nonatomic) BOOL scrollingFlag;


@property (nonatomic) UILabel *chatLabel;
@property (nonatomic) UILabel *designLabel;
@property (nonatomic) UILabel *shopLabel;

@property (nonatomic) int section;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self setUpView];
    [self setUpScrollView];
    [self setupViewControllers];

    [self createCustomSliderView];
    
    // 3 sections: Chat, Design, and Shop
    self.scrollingFlag = YES;

}

- (void) setUpView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];

}

- (void) setUpScrollView {
    
    //standard UIScrollView is added
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height-120)];
    
    self.scrollView.delegate = self;
    
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*3, self.scrollView.bounds.size.height); //this must be the appropriate size!
    
    
   
}

- (void) setupViewControllers {
    
    //just adding 3 controllers
    self.chatTVC = [[ChatTableViewController alloc] initWithPosition:0];
    [self.scrollView addSubview:self.chatTVC.view];
    
    self.designVC = [[DesignViewController alloc] initWithPosition:1];
    [self.scrollView addSubview:self.designVC.view];
    
    self.shopTVC = [[ShopTableViewController alloc] initWithPosition:2];
    [self.scrollView addSubview:self.shopTVC.view];
    
    [self.view addSubview:self.scrollView];


}

- (void) createCustomSliderView {
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(5, 65, self.view.bounds.size.width - 10, 30)];
    [self.sliderView setBackgroundColor:[UIColor lightGrayColor]];
    self.sliderView.layer.cornerRadius = 15.0;
    self.sliderView.layer.masksToBounds = YES;

    
    self.slideButtonView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.slideButtonView.tag = 0;
    self.slideButtonView.alpha = 0.7;
    [self.slideButtonView setBackgroundColor:[UIColor whiteColor]];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    
    self.chatLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [self.chatLabel setBackgroundColor:[UIColor redColor]];
    self.chatLabel.textAlignment = NSTextAlignmentCenter;
    self.chatLabel.text = @"Chat";
    self.chatLabel.textColor = [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
    [self.chatLabel addGestureRecognizer:tapRecognizer];
    self.chatLabel.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapDesignRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    
    self.designLabel = [[UILabel alloc] initWithFrame:
                        CGRectMake(self.view.bounds.size.width/2 - 50.0f, 0, 100, 30)];
    self.designLabel.text = @"Design";
    self.designLabel.textAlignment = NSTextAlignmentCenter;
    [self.designLabel setBackgroundColor:[UIColor redColor]];
    [self.designLabel addGestureRecognizer:tapDesignRecognizer];
    self.designLabel.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapShopRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    
    self.shopLabel = [[UILabel alloc] initWithFrame:
                      CGRectMake(self.view.bounds.size.width- 100, 0, 100, 30)];
    self.shopLabel.text = @"Shop";
    [self.shopLabel addGestureRecognizer:tapShopRecognizer];
    [self.shopLabel setBackgroundColor:[UIColor redColor]];
    self.shopLabel.userInteractionEnabled = YES;
    self.shopLabel.textAlignment = NSTextAlignmentCenter;

    [self.sliderView addSubview:self.chatLabel];
    [self.sliderView addSubview:self.designLabel];
    [self.sliderView addSubview:self.shopLabel];
    [self.sliderView addSubview: self.slideButtonView];
    
    [self.view addSubview:self.sliderView];

}

- (void) tapped:(UIGestureRecognizer *)gesture {
    
    self.scrollingFlag = NO;
    
    CGRect frame = self.slideButtonView.frame;
    if (gesture.view == self.chatLabel) {
        frame.origin.x = 0.0f ;
        [self.scrollView setContentOffset:CGPointMake(self.view.bounds.size.width*0, 0) animated:YES];
        [self changeTextColor:0];

    } else if (gesture.view == self.designLabel) {
        frame.origin.x = self.view.bounds.size.width/2.0f - 50.0f;
        [self.scrollView setContentOffset:CGPointMake(self.view.bounds.size.width*1, 0) animated:YES];
        [self changeTextColor:1];
    } else if (gesture.view == self.shopLabel) {
        
        frame.origin.x = self.view.bounds.size.width - 100.0f;
        [self.scrollView setContentOffset:CGPointMake(self.view.bounds.size.width*2, 0) animated:YES];
        [self changeTextColor:2];

    }
    self.slideButtonView.frame = frame;
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];

    if ([touch view] == self.slideButtonView) {
   
        CGRect frame = self.slideButtonView.frame;
        frame.origin.x = location.x;
        self.slideButtonView.frame = frame;
        
        [self.scrollView setContentOffset:CGPointMake(2*location.x, 1)];
    }
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    CGRect frame = self.slideButtonView.frame;
    

    if ([touch view] == self.slideButtonView) {
        
        float sliderValue = location.x / self.view.bounds.size.width;

        if (sliderValue > .25 && sliderValue < .75) {
            // Design
            NSLog(@"3.) %f", (self.view.bounds.size.width/2.0f));
            self.section = 1;
            frame.origin.x = self.view.bounds.size.width/2.0f - 50.0;
            [self.scrollView setContentOffset:CGPointMake(self.view.bounds.size.width*1, 0) animated:YES];
            [self changeTextColor:1];
            
        } else if (sliderValue > .50) {
                 NSLog(@"2.)");
            // Shop
            frame.origin.x = self.view.bounds.size.width - 100.0f;
            self.section = 2;

            [self.scrollView setContentOffset:CGPointMake(self.view.bounds.size.width*2, 0) animated:YES];
            [self changeTextColor:2];
        } else if (sliderValue < .25) {
            // Chat
            NSLog(@"1.)");
            
            self.section = 0;
            frame.origin.x = 0.0f;
            [self.scrollView setContentOffset:CGPointMake(self.view.bounds.size.width*0, 0) animated:YES];
            [self changeTextColor:0];
        }
        
          self.slideButtonView.frame = frame;
        NSLog(@"3.1) %f", self.slideButtonView.frame.origin.x);
    }
    
    
}

- (void) changeTextColor :(int) label{
    if (label == 0) {
        self.chatLabel.textColor = [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
        self.shopLabel.textColor= [UIColor blackColor];
        self.designLabel.textColor = [UIColor blackColor];
    } else if (label == 1) {
        self.chatLabel.textColor = [UIColor blackColor];
        self.shopLabel.textColor= [UIColor blackColor];
        self.designLabel.textColor = [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
        
    } else {
        
        self.chatLabel.textColor = [UIColor blackColor];
        self.shopLabel.textColor= [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
        self.designLabel.textColor =  [UIColor blackColor];

        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{


    

    
        CGRect frame = self.slideButtonView.frame;
        frame.origin.x = (scrollView.contentOffset.x/2.0) - 50.0f;
    NSLog(@"1.) %f", self.sliderView.bounds.size.width);
    NSLog(@"1.) %f", self.view.bounds.size.width);
        self.slideButtonView.frame = frame;

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGRect frame = self.slideButtonView.frame;
    

    if (scrollView.contentOffset.x < 750.0/3.0) {
        self.section = 0;
        frame.origin.x = 0.0f ;
        [self changeTextColor:0];
        
    } else if ((scrollView.contentOffset.x > 750.0/3.0) && scrollView.contentOffset.x < 750.0*(2.0/3.0)) {

        self.section = 1;
        frame.origin.x = self.view.bounds.size.width/2.0f - 50.0f;
        [self changeTextColor:1];
        
    } else if (scrollView.contentOffset.x > 750.0*(2.0/3.0)) {

        self.section = 2;
        frame.origin.x = self.view.bounds.size.width - 100.0f;
        [self changeTextColor:2];
    }
    self.slideButtonView.frame = frame;

}

@end

