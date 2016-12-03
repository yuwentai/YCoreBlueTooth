//
//  TempBle.m
//  SmartClothes
//
//

#import "TempBle.h"
@interface TempBle ()

@end

@implementation TempBle
static TempBle *TemCmanager = nil;
+(id)shareManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TemCmanager = [[TempBle alloc] init];
    });

    return TemCmanager;

}

//初始化信息
-(void)initWithCenterManager{
    
    TemCmanager.TempCenM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];

}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBManagerStatePoweredOn:
            [self StartScan];
            //如果蓝牙是开启的会开始扫面设备 如果蓝牙没开会提示你打开蓝牙
            break;
        case CBManagerStatePoweredOff:
            
        {
            NSLog(@"蓝牙是关闭的");
                       
        }
            
            break;
        default:
            
            NSLog(@"Central Manager did change state");
            break;
    }
    
}

//蓝牙开启扫描服务
-(void)StartScan{
    
    
    [self.TempCenM scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@""]] options:nil];
    //这里需要写入你硬件Service的uuid
    if (self.periphral == nil) {
       
    }

}


//发现服务
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    if (self.periphral != peripheral) {
        self.periphral = peripheral;
//        NSLog(@"找到设备:%@",self.periphral);
        if ([self.delegate respondsToSelector:@selector(faxinanTemp:)]) {
            [self.delegate faxinanTemp:peripheral];
        }else if (peripheral == nil)
            NSLog(@"没有检测到设备");
    }
}


//连接上外围设备后我们就要找到外围设备的服务特性
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"连接成功");
    
    [self.TempCenM stopScan];
    Pertemp *per = [Pertemp sharemanager];
    per.peripheral = peripheral;
    per.peripheral.delegate = per;
    [per.peripheral discoverServices:@[[CBUUID UUIDWithString:@""]]];
    //这里还是需要写入你硬件Service的uuid
    
}

//从连接状态断开
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"断开连接");
    [_TempCenM connectPeripheral:_periphral options:nil];

}
//连接失败
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"断开连接");
    [_TempCenM connectPeripheral:_periphral options:nil];

}
//断开连接
-(void)disConnect{
    if (_periphral != nil) {
       [self.TempCenM cancelPeripheralConnection:_periphral];
        self.TempCenM = nil;
        [self.TempCenM stopScan];
    }
}




@end
