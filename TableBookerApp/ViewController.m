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

@property (weak, nonatomic) IBOutlet UIButton *btnReserve;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
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

-(void) updateReservationList{
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
    NSArray *results = [moc executeFetchRequest:request error:nil];
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    
    for (Guest *g in results) {
        [buffer appendFormat:@"%@,%@", g.name, g.guests_quantity];
    }
    self.outputLabel.text = buffer;
}

@end
