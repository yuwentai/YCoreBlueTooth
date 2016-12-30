//
//  Pertemp.m
//  SmartClothes
//
//

#import "Pertemp.h"

@interface Pertemp ()

@end

@implementation Pertemp
//单利初始化
static Pertemp *perM = nil;
+(id)sharemanager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        perM = [[Pertemp alloc] init];
    });
    return perM;
}
#pragma mark 周边设备代理
//发现服务后
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
//提示：没有uuid连接上会因为找不到特征崩溃 你会看到下面打印信息已经连接上设备只是没有服务里的uuid找不到服务里面的特征
    for (CBService *ser in [self.peripheral services] ) {
        NSLog(@"ser.uuid:%@",ser.UUID);
        //这里需要写入你硬件Service的uuid
        if ([ser.UUID isEqual:[CBUUID UUIDWithString:@""]]) {
            self.Tservice = ser;

// 找到服务之后就开始找你硬件服务里面特征的uuid了
            [self.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:@""],[CBUUID UUIDWithString:@""]] forService:self.Tservice];
//在这里面写入你服务里的所有特征 服务里面有几个特征就写几个，我这里写了两个，很简单 加个逗号就得了
        }
    }
}

//一个特征被发现周边代理会接收
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{

    for (CBCharacteristic *tcbc in [service characteristics]) {
        if ([tcbc.UUID isEqual:[CBUUID UUIDWithString:@""]]) {
            //这个需要传入通知的uuid
            self.tqcharacteristic = tcbc;
            
            [self.peripheral setNotifyValue:YES forCharacteristic:self.tqcharacteristic];//就是因为这个方法这里接收的是通知的uuid
            
        }else if ([tcbc.UUID isEqual:[CBUUID UUIDWithString:@""]]){
        //这里是传入的是写数据uuid，写数据下面有一个方法
            self.twcharacteristic = tcbc;
        }
    }
}
//根据通知特征的uuid处理App接收的蓝牙数据
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if ([characteristic.UUID.UUIDString isEqualToString:@""]) {
//    接收数据
    const unsigned char * hexBytesLight = [characteristic.value bytes];
        NSLog(@"shuju:%s",hexBytesLight);//打印你接收的数据
//数据处理会在我的博客里面再介绍
        
//        NSString *stringA = [NSString stringWithFormat:@"%02x",hexBytesLight[0]];
//        NSString * string = [NSString stringWithFormat:@"%02x",hexBytesLight[1]];
//        NSString *stringB = [NSString stringWithFormat:@"%02x",hexBytesLight[2]];
//        NSString *stringC = [NSString stringWithFormat:@"%02x",hexBytesLight[3]];
    }
}



//向硬件写入数据 在需要写入数据的界面调用这个方法就可以
-(void)sendTempData:(NSData *)data{
    if (self.twcharacteristic != nil) {
        [self.peripheral writeValue:data forCharacteristic:self.twcharacteristic type:CBCharacteristicWriteWithResponse];
    }
}
@end
