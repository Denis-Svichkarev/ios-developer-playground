//
//  Animal.m
//  Sample Project Obj-C
//
//  Created by Denis Svichkarev on 26.08.2024.
//

#import "Animal.h"
#import "Person.h"

@implementation Animal

- (instancetype)initWithName:(NSString *)name owner:(Person *)owner {
    self = [super init];
    if (self) {
        _name = name;
        _owner = owner;
    }
    return self;
}

- (void)bark {
    NSLog(@"%@ is barking...", self.name);
}

- (void)barkWithCompletion:(CompletionBlock)completion {
    NSLog(@"%@ is barking...", self.name);
    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            NSLog(@"%@ finished barking", strongSelf.name);
            if (completion) {
                completion(YES);
            }
        } else {
            NSLog(@"Object is deallocated, unable to access name.");
        }
    });
}

- (void)dealloc {
    NSLog(@"%@ is being deinitialized", self.name);
}

@end
