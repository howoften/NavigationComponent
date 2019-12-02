//
//  ViewController.m
//  NavigationComponent
//
//  Created by 刘江 on 2019/11/30.
//  Copyright © 2019 Liujiang. All rights reserved.
//

#import "ViewController.h"
#import "NavigationController.h"
#import "LLNavigationComponent.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 44)];
    view.backgroundColor = [UIColor redColor];
    self.navigationBar.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
}


- (IBAction)push:(id)sender {
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"aaa"];
    vc.navigationBar.showNavigationBarSeparator = YES;
    vc.view.backgroundColor = [UIColor whiteColor];

    [LLNavigationComponent openViewController:vc];
}

- (IBAction)opemModal:(id)sender {
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"aaa"];
    vc.navigationBar.showNavigationBarSeparator = YES;
    vc.view.backgroundColor = [UIColor whiteColor];
        [LLNavigationComponent openViewControllerFromModalStyle:vc];

}

- (IBAction)back:(id)sender {
    [LLNavigationComponent goback];
}

- (IBAction)backroot:(id)sender {
    [LLNavigationComponent gotoRoot];
}
- (void)dealloc {
    
}
@end
