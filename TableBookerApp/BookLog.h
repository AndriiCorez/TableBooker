//
//  BookLog.h
//  TableBookerApp
//
//  Created by Andres on 1/4/16.
//  Copyright (c) 2016 Andres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Table;

@interface BookLog : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSSet *guest;
@property (nonatomic, retain) NSSet *table;
@end

@interface BookLog (CoreDataGeneratedAccessors)

- (void)addGuestObject:(NSManagedObject *)value;
- (void)removeGuestObject:(NSManagedObject *)value;
- (void)addGuest:(NSSet *)values;
- (void)removeGuest:(NSSet *)values;

- (void)addTableObject:(Table *)value;
- (void)removeTableObject:(Table *)value;
- (void)addTable:(NSSet *)values;
- (void)removeTable:(NSSet *)values;

@end
