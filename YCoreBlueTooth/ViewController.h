//
//  ViewController.h
//  YCoreBlueTooth
//
//  Created by 智裳科技 on 16/12/3.
//  Copyright © 2016年 com.yuwentai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempBle.h"
//遵循道理协议方法
@interface ViewController : UIViewController<TempCenterDelegate>

@property(nonatomic,retain)TempBle *Manger;
@end

