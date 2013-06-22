//
//  OrderList.m
//  OrederOS
//
//  Created by Edward on 13-5-23.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "OrderList.h"




@implementation OrderList
//@synthesize orederListArray;


+(OrderList *)defaultStore{
    static OrderList *orderList=nil;
    if (!orderList) {
        orderList=[[super allocWithZone:nil]init];
    }
    return orderList;
}


+(id)allocWithZone:(NSZone *)zone{
    return [self defaultStore];//不用管的内存警告
}
-(id)init{
    
    self=[super init];
    if (self) {
        //totolep=0;
        
    }
    return self;
}
/*
+(id)alloc{
    //if (isFromSelf) {
      //  return [super alloc];
   // }
   // else
        return nil;
}

-(void)dealloc{
    [orederListArray release];
    orederListArray=nil;
    [super dealloc];
}*/
-(void)setTotoleValue:(double)t{
    totolep+=t;
    NSLog(@"totlep=%lf",totolep);
}
-(double)totolep{
    return totolep;
}

-(void)addOrederList:(NSDictionary *)diction{
    if (orederListArray==nil) {
        orederListArray=[[NSMutableArray alloc]initWithCapacity:0];
        totolep=0;
        NSLog(@"totlep=%lf",totolep);
    }
    int n=-1;
    NSString *string=[diction objectForKey:@"num"];
    for (int i=0; i<[orederListArray count];i++) {
        NSDictionary *dic=[orederListArray objectAtIndex:i];
        if ([[dic objectForKey:@"id"]isEqual:[diction objectForKey:@"id"]]||string.intValue<0) {
            //if ([[diction objectForKey:@"num"]isEqual:@"0"]) {
            if (string.intValue<=0) {
                [orederListArray removeObjectAtIndex:i];   
            }else
            {
                [dic setValue:[diction objectForKey:@"num"] forKey:@"num"];
                [dic setValue:[diction objectForKey:@"totalSpace"] forKey:@"totalSpace"];
            }
             n=1;
            break;
        }
    }
    
    if (n==-1&&string.intValue>0) {
        [orederListArray addObject:diction];
    }
    
}



-(NSArray * )orederListArray{
    return orederListArray;
}


@end
