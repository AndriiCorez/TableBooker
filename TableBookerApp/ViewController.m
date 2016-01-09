//
//  ViewController.m
//  TableBookerApp
//
//  Created by Andres on 1/4/16.
//  Copyright (c) 2016 Andres. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *guestNameInput;
@property (weak, nonatomic) IBOutlet UITextField *guestQuantityInput;
@property (weak, nonatomic) IBOutlet UIPickerView *tableWheel;

@property (weak, nonatomic) IBOutlet UIButton *btnReserve;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteGuests;
@property (weak, nonatomic) IBOutlet UITextView *outputText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    //TO DO - READ TABLES DATA FROM XML FILE
    NSMutableArray *tables = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    [self updateTables];
    [self updateReservationList];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reserveBtnTapped:(id)sender {
    self.btnReserve.enabled = NO;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    Guest *guest = [self.appDelegate createGuestMO];
    guest.name = self.guestNameInput.text;
    guest.guests_quantity = [f numberFromString:self.guestQuantityInput.text];
    
    //TO DO Date, Tables, Notes
    [self.appDelegate saveContext];
    [self updateReservationList];
    self.btnReserve.enabled = YES;
}

- (IBAction)deleteBtnTapped:(id)sender {
    self.btnDeleteGuests.enabled = NO;
    
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
    
    NSError *error = nil;
    
    NSArray *results = [moc executeFetchRequest:request error:&error];
    //NSMutableString *buffer = [NSMutableString stringWithString:@""];
    
    for(Guest *g in results){
        [moc deleteObject:g];
    }
    
    [self.appDelegate saveContext];
    [self updateReservationList];
    self.btnDeleteGuests.enabled = YES;
    
}

-(void) updateReservationList{
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
    
    NSError *error = nil;
    
    NSArray *results = [moc executeFetchRequest:request error:&error];
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    
    for (Guest *g in results) {
        [buffer appendFormat:@"%@,%@\n", g.name, g.guests_quantity];
    }
    self.outputText.text = buffer;
}

-(void) updateTables{
    [self.tableWheel ]
}

@end
