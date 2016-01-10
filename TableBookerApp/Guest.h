//
//  Guest.h
//  TableBookerApp
//
//  Created by Andres on 1/4/16.
//  Copyright (c) 2016 Andres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookLog;

@interface Guest : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * guests_quantity;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) BookLog *booking;

@end
