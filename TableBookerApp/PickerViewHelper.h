//
//  PickerViewHelper.h
//  TableBookerApp
//
//  Created by Andres on 1/9/16.
//  Copyright (c) 2016 Andres. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewHelper : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

-(void)setArray:(NSArray*)array;
-(void)addItemToArray:(NSObject*)item;
-(NSObject*)getItemFromArray:(NSUInteger)index;


@end
