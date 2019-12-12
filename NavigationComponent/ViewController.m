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
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (nonatomic)NSUInteger index;
@property (weak, nonatomic) IBOutlet UILabel *levelNum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 414, 80)];
//    view.backgroundColor = [UIColor redColor];
    if (self.navigationController.childViewControllers.count != 1) {
        self.navigationBar.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    }else {
        self.navigationBar.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    }
    self.navigationItem.title = @"标题";
    self.level.text = [NSString stringWithFormat:@"第%lu层", [self.navigationController.childViewControllers count]];
    self.index = (self.navigationController.viewControllers.count > 1) ? 1 : 0;
    self.levelNum.text = [NSString stringWithFormat:@"%lu", self.index];
}


- (IBAction)push:(id)sender {
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"aaa"];
    vc.navigationBar.showNavigationBarSeparator = YES;
//    vc.view.backgroundColor = [UIColor whiteColor];

    [LLNavigationComponent openViewController:vc];
}

- (IBAction)opemModal:(id)sender {
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"aaa"];
    vc.navigationBar.showNavigationBarShadow = YES;
//    vc.view.backgroundColor = [UIColor whiteColor];
        [LLNavigationComponent openViewControllerFromModalStyle:vc];

}

- (IBAction)back:(id)sender {
    [LLNavigationComponent gobackTimes:self.index];
}

- (IBAction)backroot:(id)sender {
    [LLNavigationComponent gotoRoot];
}
- (void)dealloc {
    
}
- (IBAction)increase:(id)sender {
    if (self.index < self.navigationController.viewControllers.count-1) {
        self.index++;
        self.levelNum.text = [NSString stringWithFormat:@"%lu", self.index];

    }
    
}
- (IBAction)decrease:(id)sender {
    if (self.index > 0) {
        self.index--;
        self.levelNum.text = [NSString stringWithFormat:@"%lu", self.index];

    }
}
@end
