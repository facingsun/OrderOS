//
//  OrderList.h
//  OrederOS
//
//  Created by Edward on 13-5-23.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

//static double totolep=0;

@interface OrderList : NSObject
{
    //NSMutableArray *allItems;
    NSMutableArray *orederListArray;
    double totolep;
  
}
//@property(nonatomic,assign)NSMutableArray *orederListArray;

+(OrderList *)defaultStore;

-(void)addOrederList:(NSDictionary *)diction;

-(NSArray *)orederListArray;
-(void)setTotoleValue:(double)t;
-(double)totolep;


@end
