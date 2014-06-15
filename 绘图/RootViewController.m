//
//  RootViewController.m
//  绘图
//
//  Created by lanou3g on 14-6-15.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "RootViewController.h"
#import "DoodleView.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DoodleView * doodleView = [[DoodleView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    doodleView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:doodleView];
    [doodleView release];
    
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
