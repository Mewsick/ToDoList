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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoTable.dataSource = self;
    self.toDoTable.delegate = self;
    self.inputField.delegate = self;
    if([self loadState] != nil){
        self.arrayOfDictionaries = [self loadState];
        //packa upp array of dictionarys och konvertera till objectInArray
        self.listOfTasks = [self convertDictionaryToArrayOfObjects:self.arrayOfDictionaries];
        NSLog(@"Added task : %@", self.listOfTasks);
    }else{
        self.listOfTasks = [[NSMutableArray alloc] init];
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
        NSLog(@"trying to add dictionary: %@", dict);
        [self addDictionaryToArray:dict];
        [self saveState];
        
        [self.toDoTable reloadData];
        self.inputField.text = @"";
    }
}

- (NSMutableArray*) convertDictionaryToArrayOfObjects:(NSMutableArray*)dict{
    objectInArray *obj = [objectInArray new];
    NSMutableArray *tasks = [NSMutableArray new];
    for (int i = 0; i < dict.count; i++) {
        NSString *isUrgent = [dict valueForKey:@"isUrgent"];//accessa rätt värde
        if([isUrgent isEqualToString:@"1"]){
            obj.isUrgent = YES;
        }else{
            obj.isUrgent = NO;
        }
        obj.taskDescription = [dict valueForKey:@"description"];
        [tasks addObject:obj];
    }
    return tasks;
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

- (void) saveState{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.arrayOfDictionaries forKey:@"state"];
    [defaults synchronize];
    NSLog(@"Saved state : %@", self.arrayOfDictionaries);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    objectInArray *markUrgent = self.listOfTasks[indexPath.row];
    if(markUrgent.isUrgent == YES){
        markUrgent.isUrgent = NO;
    }else{
        markUrgent.isUrgent = YES;
    }
    [self.toDoTable reloadData];
    //ändra isUrgent för objektet på index indexPath.row i arrayOfDictionaries
    //NSDictionary *dict = [self convertObjectToDictionary: markUrgent];
    //säkerställ att man bara ändrar isUrgent
    //[self.arrayOfDictionaries setObject:dict atIndexedSubscript:indexPath.row];
    //[self saveState];
}

- (NSMutableArray*) loadState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arrayOfSavedState = [NSMutableArray new];
    arrayOfSavedState = [defaults objectForKey:@"state"];
    NSLog(@"To be loaded : %@", arrayOfSavedState);
    return arrayOfSavedState;

    /*
    for (int i = 0; i < ; i++) {
        NSMutableDictionary *dic = [defaults objectForKey:[NSString stringWithFormat:@"task%d", i]];
    }
    
    NSString *isUrgent = [dic objectForKey:@"isUrgent"];
    objectInArray *obj = [[objectInArray alloc]init];
        if ([isUrgent isEqualToString:@"1"]) {
            obj.isUrgent = YES;
        }else{
            obj.isUrgent = NO;
        }
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < dic.count; i++) {
        NSString *indexKey = [NSString stringWithFormat:@"index%d", i];
        arr[i] = [dic objectForKey:indexKey];
    }
    return arr;*/
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    objectInArray *thisTask = self.listOfTasks[indexPath.row];
    cell.textLabel.text = thisTask.taskDescription;
  
    if(thisTask.isUrgent == YES){
        cell.backgroundColor = UIColor.greenColor;
    }else{
        cell.backgroundColor = UIColor.systemBackgroundColor;
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfTasks.count;
}

- (void) addDictionaryToArray:(NSMutableDictionary*)dic {
    [self.arrayOfDictionaries addObject:dic];
    NSLog(@"added dictionary: %@", dic);
    NSLog(@"to array: %@", self.arrayOfDictionaries);
}

@end










