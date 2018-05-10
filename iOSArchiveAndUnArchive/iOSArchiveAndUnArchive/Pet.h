//
//  Pet.h
//  iOSArchiveAndUnArchive
//
//  Created by 石学谦 on 2018/5/7.
//  Copyright © 2018年 石学谦. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"

@interface Pet : NSObject<NSCoding>

@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)Person *master;

@end

