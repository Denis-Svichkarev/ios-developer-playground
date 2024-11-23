//
//  Person.h
//  Sample Project Obj-C
//
//  Created by Denis Svichkarev on 25.08.2024.
//

#import <Foundation/Foundation.h>
#import "Animal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, assign, getter=isEmployed) BOOL employed;

@property (nonatomic, strong) Animal *pet;
//@property (nonatomic, strong) NSHashTable *friends; // for unique elements
@property (nonatomic, strong) NSPointerArray *friends;

- (instancetype)initWithFirstName:(NSString *)firstName LastName:(NSString *)lastName age:(NSInteger)age;

- (NSInteger)getAge;
- (void)setAge:(NSInteger)age;
- (NSString *)getFullName;

- (void)greet;
- (void)walkTheDog;

- (void)addFriend:(Person *)person;
- (nonnull NSString *)methodWithMistake;

@end

NS_ASSUME_NONNULL_END
