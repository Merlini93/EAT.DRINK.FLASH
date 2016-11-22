//
//  LADXMLParser.h
//  EAT.DRINK.FLASH
//
//  Created by 李遨东 on 16/3/14.
//  Copyright © 2016年 Merlini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LADXMLParser : NSObject

- (NSArray *)getModelArrayWithXMLData:(NSXMLParser *)parser;

@end
