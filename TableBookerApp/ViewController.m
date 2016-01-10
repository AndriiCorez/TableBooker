//
//  ViewController.m
//  TableBookerApp
//
//  Created by Andres on 1/4/16.
//  Copyright (c) 2016 Andres. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PickerViewHelper.h"

@interface ViewController ()
@property (nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *guestNameInput;
@property (weak, nonatomic) IBOutlet UITextField *guestQuantityInput;
@property (weak, nonatomic) IBOutlet UIPickerView *tableWheel;
@property (nonatomic) PickerViewHelper *tableRollerHelper;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateTime;
@property (weak, nonatomic) IBOutlet UITextView *notesGuest;

@property (weak, nonatomic) IBOutlet UIButton *btnReserve;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteGuests;
@property (weak, nonatomic) IBOutlet UITextView *outputText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    //TO DO - READ TABLES DATA FROM XML FILE
    self.tableRollerHelper = [[PickerViewHelper alloc] init];
    [self.tableWheel setDelegate:self.tableRollerHelper];
    [self.tableWheel setDataSource:self.tableRollerHelper];
    [self updateTableRoller];
    [self updateReservationList];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reserveBtnTapped:(id)sender {
    self.btnReserve.enabled = NO;

    //[self.dateTime date];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    Guest *guest = [self.appDelegate createGuestMO];
    guest.name = self.guestNameInput.text;
    guest.guests_quantity = [f numberFromString:self.guestQuantityInput.text];
    guest.notes = self.notesGuest.text;
    Table *table = [self.appDelegate createTableMO];
    table.table_number = [NSString stringWithFormat: @"%ld", [self.tableWheel selectedRowInComponent:0]];
    BookLog *bookLog = [self.appDelegate createBookLogMO];
    bookLog.time = [self.dateTime date];
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

- (void) updateReservationList{
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BookLog"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if(!results)
        NSLog(@"Error with updating reservation list - %@", [error userInfo]);
    
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    
    for (BookLog *reservation in results) {
        [buffer appendFormat:@"%@ %@ %@\n", reservation.guest,reservation.table, reservation.time];
    }
    self.outputText.text = buffer;
}

- (NSArray*)setDefaultTables{
    return [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
}

- (void)updateTableRoller{
    
    [self.tableRollerHelper setArray:[self setDefaultTables]];
    [self.tableWheel reloadAllComponents];
}



@end
