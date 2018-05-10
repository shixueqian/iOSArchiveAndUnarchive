//
//  Pet.m
//  iOSArchiveAndUnArchive
//
//  Created by 石学谦 on 2018/5/7.
//  Copyright © 2018年 石学谦. All rights reserved.
//

#import "Pet.h"

@implementation Pet

//NSCoding协议方法：将需要归档的属性进行归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.master forKey:@"master"];
}

//NSCoding协议方法：将需要解档的属性进行解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.master = [aDecoder decodeObjectForKey:@"master"];
    }
    return self;
}

//重写description方法，方便直接打印对象
- (NSString *)description {
    return [NSString stringWithFormat:@"pet.name=%@,pet.master:%@",self.name,self.master];
}

@end
