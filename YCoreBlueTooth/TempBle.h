//
//  TempBle.h
//  SmartClothes
//
//  Created by 智裳科技 on 16/9/18.
//  Copyright © 2016年 com.zhishangkeji.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "Pertemp.h"
@protocol TempCenterDelegate <NSObject>

-(void)faxinanTemp:(CBPeripheral *)name;

@end

@interface TempBle : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>{

    CBCharacteristic *characteristic;

}
+(id)shareManager;
-(void)initWithCenterManager;
-(void)disConnect;
@property(nonatomic,strong)CBCentralManager *TempCenM;
@property(nonatomic,strong)CBPeripheral *periphral;
@property(nonatomic,retain)id<TempCenterDelegate>delegate;
@end
