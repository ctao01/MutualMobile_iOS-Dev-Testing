//
//  MMCheckInViewController.m
//  MMSocial
//
//  Created by Joy Tao on 1/11/13.
//  Copyright (c) 2013 Mutual Mobile, LLC. All rights reserved.
//

#import "MMCheckInViewController.h"
#import "RootViewController.h"

#define TAG 1000

@interface MMCheckInViewController ()


@end

@implementation MMCheckInViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    newCheckinsData = [[NSMutableDictionary alloc]init];
    
    UIBarButtonItem * checkinsItem = [[UIBarButtonItem alloc]initWithTitle:@"Check Ins" style:UIBarButtonItemStyleDone target:self action:@selector(checkInsDone)];
    self.navigationItem.rightBarButtonItem = checkinsItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void) checkInsDone
{
    RootViewController * vc = (RootViewController*)[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
    [newCheckinsData setObject:[NSDate date] forKey:@"timestamp"];
    
    
    //TODO:
    NSMutableDictionary * coord = [[NSMutableDictionary alloc]init];
    [coord setObject:[NSNumber numberWithFloat:30.2651676] forKey:@"latitude"];
    [coord setObject:[NSNumber numberWithFloat:-97.7603454] forKey:@"longitude"];
    [newCheckinsData setObject:coord forKey:@"locationCoordinates"];
    
    [vc.collections addObject:newCheckinsData];

    NSBundle *bundle;
    NSString *filePath;
    bundle      = [NSBundle mainBundle];
    filePath    = [bundle pathForResource:@"SampleData" ofType:@"plist"];
    
    [vc.collections writeToFile:filePath atomically:YES];
    if ([vc.collections writeToFile:filePath atomically:NO])
        NSLog(@"Error!!!");
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITextField

-(UITextField*) makeTextFieldwithTag:(NSInteger)tag
{
    UITextField * tf = [[UITextField alloc] initWithFrame:CGRectMake(100.0f, 0.0f, 200.0f, 44.0f)];
    tf.center = CGPointMake(tf.center.x, 35.0f);

    tf.tag = tag;
	tf.autocorrectionType = UITextAutocorrectionTypeNo ;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.adjustsFontSizeToFitWidth = YES;
    tf.delegate = self;
	return tf ;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UITextField * textField = nil;

    if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Name";
        cell.tag = TAG + indexPath.row;
        textField = [self makeTextFieldwithTag:cell.tag];
        [cell addSubview:textField];
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"Comment";
        cell.tag = TAG + indexPath.row;
        textField = [self makeTextFieldwithTag:cell.tag];
        [cell addSubview:textField];
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"Location";
        cell.tag = TAG + indexPath.row;
        textField = [self makeTextFieldwithTag:cell.tag];
        [cell addSubview:textField];
    }
    else 
    {
        cell.textLabel.text = @"Address";
        cell.tag = TAG + indexPath.row;
        textField = [self makeTextFieldwithTag:cell.tag];
        [cell addSubview:textField];
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITextField Delegate Method

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == TAG + 0)
        [newCheckinsData setObject:textField.text forKey:@"name"];
    else if (textField.tag == TAG + 1)
        [newCheckinsData setObject:textField.text forKey:@"comment"];
    else if (textField.tag == TAG + 2)
        [newCheckinsData setObject:textField.text forKey:@"locationName"];
    else
        return;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
