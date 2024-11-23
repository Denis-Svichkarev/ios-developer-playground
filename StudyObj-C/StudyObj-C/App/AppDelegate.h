//
//  AppDelegate.h
//  Sample Project Obj-C
//
//  Created by Denis Svichkarev on 23/08/24.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

