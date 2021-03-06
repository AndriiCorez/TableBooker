//
//  PickerViewHelper.m
//  TableBookerApp
//
//  Created by Andres on 1/9/16.
//  Copyright (c) 2016 Andres. All rights reserved.
//

#import "PickerViewHelper.h"

@interface PickerViewHelper ()

@property (nonatomic)NSMutableArray *pickerData;

@end

@implementation PickerViewHelper

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id)init{
    if([super init] == nil)
        return nil;
    
    self.pickerData = [NSMutableArray arrayWithArray:@[]];
    return self;
}

-(void)setArray:(NSArray*)array{
    self.pickerData = [NSMutableArray arrayWithArray:array];
}

-(void)addItemToArray:(NSObject*)item{
    [self.pickerData addObject:item];
}

-(NSObject*)getItemFromArray:(NSUInteger)index{
    return [self.pickerData objectAtIndex:index];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[self.pickerData objectAtIndex:row] description];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

@end
