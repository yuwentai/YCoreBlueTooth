//
//  ViewController.m
//  YCoreBlueTooth
//
//  Created by 智裳科技 on 16/12/3.
//  Copyright © 2016年 com.yuwentai. All rights reserved.
//

#import "ViewController.h"
#import "Pertemp.h"
#import "TempBle.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(150, 200, 75, 75);
    [btn setTitle:@"连接" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleConnect:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    UIButton *btnD = [UIButton buttonWithType:UIButtonTypeCustom];
    btnD.frame = CGRectMake(150, 360, 75, 75);
    [btnD setTitle:@"断开" forState:UIControlStateNormal];
    [btnD addTarget:self action:@selector(handlCancle:) forControlEvents:UIControlEventTouchUpInside];
    btnD.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btnD];

}
-(void)handleConnect:(UIButton *)sender{
    self.Manger = [TempBle shareManager];
    [self.Manger initWithCenterManager];
    self.Manger.delegate = self;
}
-(void)handlCancle:(UIButton *)sender{
    
    [[TempBle shareManager] disConnect];
    
}
//实现协议方法
-(void)faxinanTemp:(CBPeripheral *)name{
    NSLog(@"peripeal:%@",name);
    [self.Manger.TempCenM connectPeripheral:name options:nil];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
