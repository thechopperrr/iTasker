//
//  ViewController.m
//  iTasker
//
//  Created by andrey on 11/4/17.
//  Copyright © 2017 andrey. All rights reserved.
//

#import "HomeViewController.h"
#import "TaskLoader.h"
#import "TaskProvider.h"
#import "TaskViewCell.h"
#import "UpdateTaskViewController.h"
#import "GroupChangeViewController.h"

static NSString *taskViewCellIdentifier = @"TaskViewCell";

@interface HomeViewController () <UITableViewDelegate, UpdateTaskViewControllerDelegate, TaskViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property TaskProvider *taskProvider;
@property NSMutableArray* selectedIndexPaths;

@end

@implementation HomeViewController

- (IBAction)addButtonPressed:(id)sender {
    [self openUpdateVCWithTask:Nil];
}

- (IBAction)groupChangeButtonPressed:(id)sender {
    GroupChangeViewController *groupChangeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GroupChangeViewController"];
    groupChangeViewController.selectedTasks = _taskProvider.getTasksForGroupChange;
    groupChangeViewController.delegate = self;
    [self.navigationController pushViewController:groupChangeViewController animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"title_app", nil);
    _taskProvider = [[TaskProvider alloc]init];
    _selectedIndexPaths = [[NSMutableArray alloc]init];
    [self setUpTexts];
    _groupChangeButton.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [self clearSelectedTasks];
    [self tryShowHideGroupButton];
    [_tableView reloadData];
}

- (void)setUpTexts{
    [_saveButton setTitle:NSLocalizedString(@"btn_add_task", nil) forState:UIControlStateNormal];
    [_groupChangeButton setTitle:NSLocalizedString(@"btn_group_change", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_taskProvider getTaskInfosWithPriority:(int)section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TaskViewCell *cell = (TaskViewCell *)[tableView dequeueReusableCellWithIdentifier:taskViewCellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TaskViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    TaskInfo* tmpInfo = [[_taskProvider getTaskInfosWithPriority:(int)indexPath.section] objectAtIndex:indexPath.row];
    [cell setUpTaskInfoAndUpdate:tmpInfo];
    cell.delegate = self;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:NSLocalizedString(@"task_header", nil), (int)section, [ @([_taskProvider getHoursForPriority:(int)section]) stringValue] ];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskViewCell *cell = (TaskViewCell *)[tableView dequeueReusableCellWithIdentifier:taskViewCellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TaskViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    [self openUpdateVCWithTask: selectedCell.taskInfo];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)saveTask:(TaskInfo *)taskInfo {
    [_taskProvider saveTask:taskInfo];
}

- (void)openUpdateVCWithTask:(TaskInfo *)taskInfo{
    UpdateTaskViewController *updateViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdateTaskViewController"];
    updateViewController.delegate = self;
    updateViewController.taskInfo = taskInfo;
    [self.navigationController pushViewController:updateViewController animated:NO];
}

- (void)cellSelected:(TaskViewCell *)cell{
    [cell selectCell];
    [self tryShowHideGroupButton];
}

- (void)cellDeselected:(TaskViewCell *)cell{
    [cell deselecttCell];
    [self tryShowHideGroupButton];
}

- (void)tryShowHideGroupButton {
    BOOL hidden = YES;
    if([_taskProvider getTasksForGroupChange].count > 1){
        hidden = NO;
    }
    [UIView transitionWithView:_groupChangeButton
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _groupChangeButton.hidden = hidden;
                    }
                    completion:NULL];
}

- (void)clearSelectedTasks{
    [_taskProvider deselectAllTasks];
    [_taskProvider updateArrays];
    [_tableView reloadData];
    
}

@end
