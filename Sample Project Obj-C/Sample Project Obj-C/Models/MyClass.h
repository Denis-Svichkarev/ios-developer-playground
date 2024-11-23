//
//  MyClass.h
//  Sample Project Obj-C
//
//  Created by Denis Svichkarev on 24.08.2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClass : NSObject

@property (nonatomic, strong) NSMutableString *name;

- (instancetype)initWithName:(NSMutableString *)name;
- (void)test;

@end

NS_ASSUME_NONNULL_END
