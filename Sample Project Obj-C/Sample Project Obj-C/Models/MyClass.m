//
//  MyClass.m
//  Sample Project Obj-C
//
//  Created by Denis Svichkarev on 24.08.2024.
//

#import "MyClass.h"

@interface MyClass()

@end

@implementation MyClass

/// Designated Initializer
- (instancetype)initWithName:(NSMutableString *)name {
    self = [super init];
    if (self) {
        //_name = name;
        _name = [name copy];
    }
    return self;
}

/// Convenience Initializer
- (instancetype)init {
    NSMutableString *name = [NSMutableString stringWithString:@"John"];
    return [self initWithName:name];
}

- (void)dealloc {
    NSLog(@"Object deallocated");
}

- (void)test {
    NSLog(@"Hello %@!", self.name);
}

@end
