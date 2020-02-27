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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoTable.dataSource = self;
    self.toDoTable.delegate = self;
    self.inputField.delegate = self;
    if([self loadState] != nil){
        self.listOfTasks = [self loadState];
    }else{
        //objectInArray *hej = [[objectInArray alloc]init];
        self.listOfTasks = [[NSMutableArray alloc] init];//WithObjects:hej, nil]; // = [NSMutableArray new];
    }
}

- (IBAction)addTask:(id)sender {
    if(![self.inputField.text isEqualToString: @""]){
        objectInArray *taskToBeAdded = [[objectInArray alloc]init];
        
        // taskToBeAdded -> dictionary
        
        
        taskToBeAdded.taskDescription = self.inputField.text;
        taskToBeAdded.backgroundColor = UIColor.systemBackgroundColor;
        taskToBeAdded.isUrgent = NO;
        [self.listOfTasks addObject:taskToBeAdded];
        [self.toDoTable reloadData];
        self.inputField.text = @"";
        //[self saveState];
    }
    NSLog(@"Created tasks: %@", self.listOfTasks);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    objectInArray *markUrgent = self.listOfTasks[indexPath.row];
    if(markUrgent.isUrgent == YES){
        markUrgent.isUrgent = NO;
    }else{
        markUrgent.isUrgent = YES;
    }
    [self.toDoTable reloadData];
    
    //[self saveState];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfTasks.count;
}

- (void) saveState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];

    for (int i = 0; i < self.listOfTasks.count; i++) {
        NSString *indexKey = [NSString stringWithFormat:@"index%d", i];
        [dic setObject:self.listOfTasks[i] forKey:indexKey];
    }
    
    [defaults setObject:dic forKey:@"state"];
    [defaults synchronize];
    NSLog(@"Saved state : %@", self.listOfTasks);
}

- (NSMutableArray*) loadState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [defaults objectForKey:@"state"];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < dic.count; i++) {
           NSString *indexKey = [NSString stringWithFormat:@"index%d", i];
        arr[i] = [dic objectForKey:indexKey];
    }
    NSLog(@"Loaded state: %@", arr);
    return arr;
}
@end










