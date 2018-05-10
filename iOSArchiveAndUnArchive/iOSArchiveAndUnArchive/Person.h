//
//  Person.h
//  iOSArchiveAndUnArchive
//
//  Created by 石学谦 on 2018/5/7.
//  Copyright © 2018年 石学谦. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic,copy)NSString *name;

@property (nonatomic,assign)NSInteger age;

//有些属性可以不进行归档
@property (nonatomic,assign)CGFloat height;

@end
