//
//  FSXml.h
//  XmlText
//
//  Created by Edward on 13-3-26.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol xmlDelegate //<NSObject>

@optional -(void)xmlParserFinished:(NSArray *)array;

@end


@interface FSXml : NSObject <NSXMLParserDelegate,NSURLConnectionDataDelegate>
{
    NSMutableArray *XMLArray;//此数组用以指向传入的array数组，array数组通过该数组获取数据。
    NSURLConnection *connection1;
    NSMutableData *xmlData;
    id<xmlDelegate> *delegate;
}
@property(nonatomic,assign)id<xmlDelegate>delegate;
-(BOOL)initWithURL:(NSString *)str XmlDataToArray:(NSMutableArray *)array;

//-(void)fetchEntries;


@end
