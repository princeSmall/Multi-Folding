# TableView1 响应
1、点击左一cell时，响应右边section

2、row的判断是必须的，保证在折叠时也可以被点击

3、scroPosition 的方向是可以改的：top，middel，none，bottom
<pre>
  NSInteger rows = [self.tableView2 numberOfRowsInSection:indexPath.row];
    if (rows == 0) {
        return;
    }
    if (tableView==self.tableView1) {
    
          NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
          
         [self.tableView2 selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];      
    }
</pre>
    
# TabelView2 header
1、自定义的section，给每个section一个折叠的fold属性

2、button添加点击事件，设置title or image

<pre>
     {    
    HeaderFooterView * headView = [[HeaderFooterView alloc]init];
    headView.frame =CGRectMake(0, 0, self.tableView2.frame.size.width, self.tableView2.frame.size.height);
    NSString *key = [NSString stringWithFormat:@"%ld",section];
    BOOL fold =[[ _foldDictionary objectForKey:key]boolValue];
    headView.fold = fold;
    headView.layer.borderWidth = 1;
    headView.layer.borderColor = [UIColor grayColor].CGColor;
    [headView addBtn:_btn andSection:section canFold:YES];
    headView.btn.tag = section +100;
    [headView.btn setTitle:[NSString stringWithFormat:@"%ld",section] forState:UIControlStateNormal];
    [headView.btn addTarget:self action:@selector(foldView:) forControlEvents:UIControlEventTouchUpInside];
    }
</pre>
    
# TableView2 折叠

1、折叠实现的方法

1.1、判断：哪个section折叠

1.2、刷新：折叠的section


    -(void)foldView:(UIButton *)sender{
    NSString *key = [NSString stringWithFormat:@"%d",(int)sender.tag-100];
    BOOL fold =[[ _foldDictionary objectForKey:key]boolValue];
    NSString * foldString = fold ? @"0" : @"1";
    [_foldDictionary setValue:foldString forKey:key];
    NSMutableIndexSet *set = [NSMutableIndexSet indexSetWithIndex:(int)sender.tag-100];
    [self.tableView2 reloadSections:set withRowAnimation:UITableViewRowAnimationFade];  
    }
