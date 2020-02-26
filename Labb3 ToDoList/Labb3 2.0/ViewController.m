//
//  ViewController.m
//  Labb3 2.0
//
//  Created by Eric Johansson on 2020-01-24.
//  Copyright © 2020 Eric Johansson. All rights reserved.
//

#import "ViewController.h"
#import "toDoCell.h"
#import "objectInArray.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *toDoTable;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;

@property objectInArray *task;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDoTable.dataSource = self;
    self.toDoTable.delegate = self;
    self.inputField.delegate = self;
    
    if([self loadState] != nil){
        self.toDoList = [self loadState];
    }else{
        self.toDoList = [NSMutableArray new];
    }
}

- (void) saveState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];

    for (int i = 0; i < self.toDoList.count; i++) {
        NSString *indexKey = [NSString stringWithFormat:@"index%d", i];
        [dic setObject:self.toDoList[i] forKey:indexKey];
    }
    
    [defaults setObject:dic forKey:@"state"];
    [defaults synchronize];
    NSLog(@"Saved state : %@", self.toDoList);
}

- (NSMutableArray*) loadState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [defaults objectForKey:@"state"];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    //objectInArray *tasks;
    
    for (int i = 0; i < dic.count; i++) {
           NSString *indexKey = [NSString stringWithFormat:@"index%d", i];
        arr[i] = [dic objectForKey:indexKey];
    }
    NSLog(@"Loaded state: %@", arr);
    return arr;
}


- (IBAction)addTask:(id)sender {
    //objectInArray *task = [[objectInArray alloc]init];
    self.task.taskDescription = self.inputField.text;
    if(![self.task.taskDescription isEqualToString: @""]){
        [self.toDoList addObject:self.task.taskDescription];
        [self.toDoTable reloadData];
        self.inputField.text = @"";
        [self saveState];
        //self.task.isUrgent = YES;
        //[self.toDoList setObject:@(task.isUrgent) atIndexedSubscript:self.toDoList.count];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    toDoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toDoCell" forIndexPath:indexPath];
    
    //objectInArray *taskModel = self.toDoList[indexPath.row];
    
    cell.callbackBlock = ^UIColor*(){
        if (self.task.isUrgent == YES){// == UIColor.greenColor){ //!taskModel.isUrgent
            return UIColor.systemBackgroundColor;
            //taskModel.isUrgent = YES;
            NSLog(@"%d", self.task.isUrgent);
        } else {
            return UIColor.greenColor;
            //NSLog(@"%d", taskModel.isUrgent);
        }
    };
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.toDoList[indexPath.row]];
    
       return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toDoList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.task.isUrgent = YES;
    //self.toDoList[indexPath.row] = //sätt en boolean för objekt [indexPath.row] i arrayen
    [self saveState];
}

@end
