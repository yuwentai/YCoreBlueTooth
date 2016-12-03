//
//  Pertemp.h
//  SmartClothes
//
//

#import <Foundation/Foundation.h>
#import "TempBle.h"
#import <CoreBluetooth/CoreBluetooth.h>

@protocol  peritempdelegate

@end


@interface Pertemp : NSObject<CBPeripheralDelegate>

@property CBPeripheral *peripheral;
@property CBService *Tservice;
@property CBCharacteristic *tqcharacteristic;
@property CBCharacteristic *twcharacteristic;
//这里前两个属性接收服务和设备 后两个特征一个接收的是通知特征另一个接受的是写数据的特征
@property(nonatomic,retain)id<peritempdelegate>delegate;
+(id)sharemanager;
-(void)sendTempData:(NSData *)data;
@end
