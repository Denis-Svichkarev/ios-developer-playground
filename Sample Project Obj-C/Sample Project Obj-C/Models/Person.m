//
//  Person.m
//  Sample Project Obj-C
//
//  Created by Denis Svichkarev on 25.08.2024.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person()

@property (nonatomic, assign) NSInteger age;

@end

@implementation Person

- (instancetype)initWithFirstName:(NSString *)firstName LastName:(NSString *)lastName age:(NSInteger)age {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
        _age = age;
        _employed = YES;
        // _friends = [NSHashTable weakObjectsHashTable]; // for unique elements
        _friends = [NSPointerArray weakObjectsPointerArray];
    }
    return self;
}

- (NSString *)getFullName {
    return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}

- (NSInteger)getAge {
    return _age;
}

- (void)setAge:(NSInteger)age {
    if (age > 0) {
        _age = age;
    }
}

- (BOOL)isEmployed {
    return _employed;
}

- (void)greet {
    NSLog(@"Hello, my name is %@ and I am %ld years old.", self.firstName, (long)[self getAge]);
}

- (void)swizzled_greet {
    NSLog(@"Before original sayHello");
    [self swizzled_greet];
    NSLog(@"After original sayHello");
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(greet);
        SEL swizzledSelector = @selector(swizzled_greet);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)walkTheDog {
    [self.pet barkWithCompletion:^(BOOL success) {
        if (success) {
            NSLog(@"%@: Good dog!", self.pet.name);
        }
    }];
}
- (void)addFriend:(Person *)person {
    [self.friends addPointer:(__bridge void * _Nullable)person];
}

- (nonnull NSString *)methodWithMistake {
    // Static analyzer test
    // NSString *string;
    
    NSString *string = [NSString string];
    return string;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(bark)) {
        return self.pet;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (void)dealloc {
    NSLog(@"%@ is being deinitialized", self.firstName);
}

@end
