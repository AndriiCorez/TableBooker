//
//  Table.h
//  TableBookerApp
//
//  Created by Andres on 1/4/16.
//  Copyright (c) 2016 Andres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Table : NSManagedObject

@property (nonatomic, retain) NSString * table_number;
@property (nonatomic, retain) NSString * table_capacity;
@property (nonatomic, retain) NSManagedObject *booking;

@end
