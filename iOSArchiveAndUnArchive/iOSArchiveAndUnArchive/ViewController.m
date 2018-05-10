//
//  ViewController.m
//  iOSArchiveAndUnArchive
//
//  Created by 石学谦 on 2018/5/7.
//  Copyright © 2018年 石学谦. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Pet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"沙盒路径：%@",NSHomeDirectory());
}

//普通数组归档
- (IBAction)onClickBtn1:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"numbers.plist"];

    NSArray *numbers = @[@"one",@"two"];

    //将数据归档到path文件路径里面
    BOOL success = [NSKeyedArchiver archiveRootObject:numbers toFile:path];

    if (success) {
        NSLog(@"归档成功");
    }else {
        NSLog(@"归档失败");
    }
    
}

//普通数组解档
- (IBAction)onClickBtn2:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"numbers.plist"];
    
    //将path文件路径的数据解档出来
    NSArray *numbers = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"numbers=%@",numbers);
}

//因为文件夹不存在造成归档失败
- (IBAction)onClickBtn1_2:(id)sender {
    
    //沙盒home目录
    NSString *docPath = NSHomeDirectory();
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"Documents/Archive/numbers.plist"];
    
    //获取文件夹路径
    NSString *directory = [path stringByDeletingLastPathComponent];
    //判断文件夹是否存在
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:nil];
    //如果不存在则创建文件夹
    if (!fileExists) {

        NSLog(@"文件夹不存在");
        //创建文件夹
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"error=%@",error.description);
        } else {
            NSLog(@"文件夹创建成功");
        }
    }
    
    NSArray *numbers = @[@"one",@"two"];
    
    //将数据归档到path文件路径里面
    BOOL success = [NSKeyedArchiver archiveRootObject:numbers toFile:path];
    
    if (success) {
        NSLog(@"归档成功");
    }else {
        NSLog(@"归档失败");
    }
    
    //将path文件路径的数据解档出来
    NSArray *unarchiveNumbers = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"unarchiveNumbers=%@",unarchiveNumbers);
}

//因为无写权限造成归档失败
- (IBAction)onClickBtn1_3:(id)sender {
    
    //安装目录
    //NSString *docPath = [[NSBundle mainBundle] bundlePath];
    //沙盒home目录
    NSString *docPath = NSHomeDirectory();
    NSLog(@"docPath=%@",docPath);
    
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"Documents/numbers.plist"];
    
    //获取文件夹路径
    NSString *directory = [path stringByDeletingLastPathComponent];
    
    if (![[NSFileManager defaultManager] isWritableFileAtPath:directory]) {
        NSLog(@"目录无写入权限");
    }
    
    NSArray *numbers = @[@"one",@"two"];
    
    //将数据归档到path文件路径里面
    BOOL success = [NSKeyedArchiver archiveRootObject:numbers toFile:path];
    
    if (success) {
        NSLog(@"归档成功");
    }else {
        NSLog(@"归档失败");
    }
    
    //将path文件路径的数据解档出来
    NSArray *unarchiveNumbers = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"unarchiveNumbers=%@",unarchiveNumbers);
}



//普通字典归档
- (IBAction)onClickBtn3:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"personDict.archive"];
    
    NSDictionary *personDict = @{
                                 @"name":@"shixueqian",
                                 @"age":@(27)
                                 };
    //将数据归档到path文件路径里面
    BOOL success = [NSKeyedArchiver archiveRootObject:personDict toFile:path];
    
    if (success) {
        NSLog(@"归档成功");
    }else {
        NSLog(@"归档失败");
    }
}

//普通字典解档
- (IBAction)onClickBtn4:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"personDict.archive"];
    
    //将path文件路径的数据解档出来
    NSDictionary *personDict = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"personDict=%@",personDict);
}

//多个普通对象同时归档
- (IBAction)onClickBtn5:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"manyData.plist"];
    
    NSInteger age = 27;
    NSString *name = @"shixueqian";
    NSArray *array = @[@"one",@"two"];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:name forKey:@"name"];
    [archiver encodeInteger:age forKey:@"age"];
    [archiver encodeObject:array forKey:@"numbers"];
    
    //完成归档
    [archiver finishEncoding];
    
    //将归档好的数据写到文件里面
    [data writeToFile:path atomically:YES];
}

//多个普通对象同时解档
- (IBAction)onClickBtn6:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"manyData.plist"];
    
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSString *name = [unarchiver decodeObjectForKey:@"name"];
    NSInteger age = [unarchiver decodeIntegerForKey:@"age"];
    NSArray *numbers = [unarchiver decodeObjectForKey:@"numbers"];
    
    [unarchiver finishDecoding];
    
    NSLog(@"name=%@，age=%zd,numbers=%@",name,age,numbers);
}

//自定义对象归档
- (IBAction)onClickBtn7:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"person.archive"];
    
    Person *person = [[Person alloc] init];
    person.name = @"谦言忘语";
    person.age = 27;
    
    //将数据归档到path文件路径里面
    BOOL success = [NSKeyedArchiver archiveRootObject:person toFile:path];
    
    if (success) {
        NSLog(@"归档成功");
    }else {
        NSLog(@"归档失败");
    }
}

//自定义对象解档
- (IBAction)onClickBtn8:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"person.archive"];
    
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"person=%@",person);
}

//自定义对象数组归档
- (IBAction)onClickBtn9:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"persons.archive"];
    
    Person *person1 = [[Person alloc] init];
    person1.name = @"大帅哥";
    person1.age = 18;
    
    Person *person2 = [[Person alloc] init];
    person2.name = @"谦言忘语";
    person2.age = 27;
    
    NSArray *persons = @[person1,person2];
    
    //将数据归档到path文件路径里面
    BOOL success = [NSKeyedArchiver archiveRootObject:persons toFile:path];
    
    if (success) {
        NSLog(@"归档成功");
    }else {
        NSLog(@"归档失败");
    }
    
}

//自定义对象数组解档
- (IBAction)onClickBtn10:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"persons.archive"];
    
    NSArray *persons = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"persons=%@",persons);
}

//自定义对象里面有另一个自定义对象归档
- (IBAction)onClickBtn11:(id)sender {
    
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"pet.archive"];
    
    Person *person = [[Person alloc] init];
    person.name = @"谦言忘语";
    person.age = 27;
    
    Pet *pet = [[Pet alloc] init];
    pet.name = @"小白";
    pet.master = person;
    
    
    //将数据归档到path文件路径里面
    BOOL success = [NSKeyedArchiver archiveRootObject:pet toFile:path];
    
    if (success) {
        NSLog(@"归档成功");
    }else {
        NSLog(@"归档失败");
    }
}

//自定义对象里面有另一个自定义对象解档
- (IBAction)onClickBtn12:(id)sender {
   
    //沙盒ducument目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //完整的文件路径
    NSString *path = [docPath stringByAppendingPathComponent:@"pet.archive"];
    
    Pet *pet = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"pet=%@",pet);
}

@end
