//
//  RootViewController.m
//  MM Social - iOS Development: Candidate Programming Test
//
//  Copyright 2011 Mutual Mobile, LLC. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "MMCheckInViewController.h"

@interface RootViewController()
- (void)loadAndSortDataFromFileAtPath:(NSString *)filePath;
- (NSMutableArray *)cleanupDupliatedObject:(NSMutableArray *)array;
- (NSMutableDictionary *) sorteddCollectionDictionary;

@property (nonatomic , retain) NSMutableArray * timestamps;

@property (nonatomic , retain) NSDictionary * collectionDictionary;
@end

@implementation RootViewController
@synthesize collections = _collections;
@synthesize timestamps = _timestamps;
@synthesize collectionDictionary = _collectionDictionary;

#pragma mark -
#pragma mark UIView Lifecycle

- (void)viewDidLoad {
    NSBundle *bundle;
    NSString *filePath;
    
    bundle      = [NSBundle mainBundle];
    filePath    = [bundle pathForResource:@"SampleData" ofType:@"plist"];
  
    [self loadAndSortDataFromFileAtPath:filePath];
    
    // TODO: Continue implementing this functionality
    
    [super viewDidLoad];

    UIBarButtonItem * addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewCheckIns)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem * refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    self.navigationItem.leftBarButtonItem = refreshButton;
    
    self.navigationItem.title = @"MM Social";
}


#pragma mark - 
#pragma mark UITableViewDataSource Conformance

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.timestamps count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.collectionDictionary objectForKey:[self.timestamps objectAtIndex:section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellID = @"JTCellID";
    UITableViewCell * cell = (UITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    NSArray * array = [self.collectionDictionary objectForKey:[self.timestamps objectAtIndex:indexPath.section]];
    cell.textLabel.text = [[array objectAtIndex:indexPath.row] objectForKey:@"name"];

    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    cell.detailTextLabel.text = [formatter stringFromDate:[[array objectAtIndex:indexPath.row] objectForKey:@"timestamp"]];
    
    return cell;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    return [formatter stringFromDate:[self.timestamps objectAtIndex:section]];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * vc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setDict:[[self.collectionDictionary objectForKey:[self.timestamps objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]];
}

#pragma mark -
#pragma Private Methods

- (void) addNewCheckIns
{
    MMCheckInViewController * vc = [[MMCheckInViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) refreshData
{
    NSBundle *bundle;
    NSString *filePath;
    
    bundle      = [NSBundle mainBundle];
    filePath    = [bundle pathForResource:@"SampleData" ofType:@"plist"];
    
    [self loadAndSortDataFromFileAtPath:filePath];
    [self.tableView reloadData];
}

- (void)loadAndSortDataFromFileAtPath:(NSString *)filePath {    
  
    // TODO: Implement this function to load and sort your model
    // HINT: NSDateComponents and NSCalendar may be useful
    self.collections = [[NSMutableArray alloc]initWithContentsOfFile:filePath];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:YES];
    [self.collections sortUsingDescriptors:[NSArray arrayWithObject: sortDescriptor]];
    
    self.timestamps = [[NSMutableArray alloc]initWithArray:[self timestamps]];
    
    self.collectionDictionary = [self sorteddCollectionDictionary];
}


- (NSDateComponents*)dateComponentsFromDate:(NSDate*)date
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit ) fromDate:date];
    
    [dateComponents setYear:[dateComponents year]];
    [dateComponents setMonth:[dateComponents month]];
    [dateComponents setDay:[dateComponents day]];
    
    return dateComponents;
}

- (NSMutableArray *) timestamps
{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int count = 0; count < [self.collections count]; count++)
    {        
        NSDateComponents *dateComponents =[self dateComponentsFromDate:[[self.collections objectAtIndex:count] objectForKey:@"timestamp"]];
        [array addObject: [[NSCalendar currentCalendar] dateFromComponents:dateComponents]];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    [array sortUsingDescriptors:[NSArray arrayWithObject: sortDescriptor]];
    
    return [self cleanupDupliatedObject:array];
}

- (NSMutableArray *)cleanupDupliatedObject:(NSMutableArray *)array
{
    NSArray *copy = [array copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([array indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [array removeObjectAtIndex:index];
        }
        index--;
    }
    [copy release];
    
    return array;
}

- (NSMutableDictionary *) sorteddCollectionDictionary
{    
    NSMutableDictionary * sortedDictionary = [[NSMutableDictionary alloc]init];
    
    for (int i = 0; i < [self.timestamps count]; i++)
    {
        NSMutableArray * array = [[NSMutableArray alloc]init];
        
        for (int j = 0; j < [self.collections count]; j++)
        {
            NSDateComponents *dateComponents =[self dateComponentsFromDate:[[self.collections objectAtIndex:j] objectForKey:@"timestamp"]];
            NSDate * date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
                        
            if ([[self.timestamps objectAtIndex:i] isEqualToDate:date])
                [array addObject:[self.collections objectAtIndex:j]];
        }
        
        [sortedDictionary setObject:array forKey:[self.timestamps objectAtIndex:i]];
    }
    return sortedDictionary;
}


#pragma mark -
#pragma Memory Management

- (void)dealloc{
    [super dealloc];
    [self.collectionDictionary release];
    [self.collections release];
    [self.timestamps release];
}

@end
