//
//  OCViewController.m
//  局部scope
//
//  Created by yunna on 2020/4/8.
//  Copyright © 2020 yunna. All rights reserved.
//

#import "OCViewController.h"

@interface OCViewController ()

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

 

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    {
        UILabel *titleLabel = [[UILabel alloc]
                initWithFrame:CGRectMake(150, 30, 200, 40)];
        titleLabel.textColor = [UIColor redColor];
        titleLabel.text = @"Title";
        [view addSubview:titleLabel];
    }

    {
        UILabel *textLabel = [[UILabel alloc]
                initWithFrame:CGRectMake(150, 80, 200, 40)];
        textLabel.textColor = [UIColor redColor];
        textLabel.text = @"Text";
        [view addSubview:textLabel];
    }

    self.view = view;
}


@end
