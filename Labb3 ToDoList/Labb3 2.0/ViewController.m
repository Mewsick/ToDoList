//
//  ViewController.m
//  Labb3 2.0
//
//  Created by Eric Johansson on 2020-01-24.
//  Copyright © 2020 Eric Johansson. All rights reserved.
//

#import "ViewController.h"
#import "objectInArray.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *toDoTable;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;
@property NSMutableArray *arrayOfDictionaries;
@property NSMutableArray *listOfTasks;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfDictionaries = [NSMutableArray new];
    self.listOfTasks = [NSMutableArray new];
    self.toDoTable.dataSource = self;
    self.toDoTable.delegate = self;
    self.inputField.delegate = self;
    if([self loadState] != nil){
        self.arrayOfDictionaries = [self loadState];
        self.listOfTasks = [self convertDictionaryToArrayOfObjects:self.arrayOfDictionaries];
        NSLog(@"Added tasks : %@", self.listOfTasks);
        for (objectInArray* o in self.listOfTasks) {
            NSLog(@"saudhuahsu %@", o.taskDescription);
        }
    }else{
        NSLog(@"Loadstate was nil");
    }
}

- (IBAction)addTask:(id)sender {
    if(![self.inputField.text isEqualToString: @""]){
        objectInArray *taskToBeAdded = [[objectInArray alloc]init];
        taskToBeAdded.taskDescription = self.inputField.text;
        taskToBeAdded.isUrgent = NO;
        
        [self.listOfTasks addObject:taskToBeAdded];
        NSMutableDictionary *dict = [self convertObjectToDictionary: taskToBeAdded];
        NSLog(@"adding dict: %@ to arrayOfDictionaries", dict);
        NSMutableArray *tempArr = [self.arrayOfDictionaries mutableCopy];
        [tempArr addObject:dict];
        self.arrayOfDictionaries = tempArr;
        NSLog(@"adding successful %@", self.arrayOfDictionaries);
        
        [self saveState];
        [self.toDoTable reloadData];
        self.inputField.text = @"";
    }
}

- (NSMutableArray*) loadState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arrayOfSavedState = [NSMutableArray new];
    arrayOfSavedState = [defaults objectForKey:@"state"];
    NSLog(@"Loading state : %@", arrayOfSavedState);
    return arrayOfSavedState;
}

- (NSMutableArray*) convertDictionaryToArrayOfObjects:(NSMutableArray*)dict{
    NSMutableArray *tasks = [NSMutableArray new];
    for (int i = 0; i < self.arrayOfDictionaries.count; i++) {
        objectInArray *obj = [objectInArray new];
        obj.taskDescription = [[dict valueForKey:@"description"] objectAtIndex:i];
        NSString *isUrgent = [[dict valueForKey:@"isUrgent"] objectAtIndex:i];
        if (isUrgent != nil) {
            if([isUrgent isEqualToString:@"1"]){
                obj.isUrgent = YES;
            }else{
                obj.isUrgent = NO;
            }
        }else{
            obj.isUrgent = NO;
        }
        NSLog(@"%@", obj.taskDescription);
        [tasks addObject:obj];
    }
    NSLog(@"tasks in dictionary converted to array: %@", tasks);
    return tasks;
}

- (void) saveState{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.arrayOfDictionaries forKey:@"state"];
    NSLog(@"Saving state : %@", self.arrayOfDictionaries);
    [defaults synchronize];
}

- (NSMutableDictionary *) convertObjectToDictionary:(objectInArray*)obj{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *isUrgent = @"";
    if(obj.isUrgent == YES){
        isUrgent = @"1";
    }else{
        isUrgent = @"0";
    }
    [dict setObject:isUrgent forKey:@"isUrgent"];
    [dict setObject:obj.taskDescription forKey:@"description"];
    return dict;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    objectInArray *markUrgent = self.listOfTasks[indexPath.row];
    if(markUrgent.isUrgent == YES){
        markUrgent.isUrgent = NO;
    }else{
        markUrgent.isUrgent = YES;
    }
    
    [self.listOfTasks setObject:markUrgent atIndexedSubscript:indexPath.row];
    NSMutableDictionary *dict = [self convertObjectToDictionary: markUrgent];
    
    NSMutableArray *tempArr = [self.arrayOfDictionaries mutableCopy];
    [tempArr addObject:dict];
    self.arrayOfDictionaries = tempArr;
    
    [self saveState];
    [self.toDoTable reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    objectInArray *obj = self.listOfTasks[indexPath.row];
    cell.textLabel.text = obj.taskDescription;
    // NSLog(@"%@", obj.taskDescription);
    if(obj.isUrgent == YES){
        cell.backgroundColor = UIColor.greenColor;
    }else{
        cell.backgroundColor = UIColor.systemBackgroundColor;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfTasks.count;
}
@end










