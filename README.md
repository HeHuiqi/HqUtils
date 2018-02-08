# HqUtils

## HqCustomKeyboard
```
Useage1:
UITextField *input  = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 200, 50)];
input.placeholder = @"请输入";
[self.view addSubview:input];
[self tapView:self.view];
HqKeyBoard *board = [HqKeyBoard new];
board.deleteImage = [UIImage imageNamed:@"delete"];
board.cancelImage = [UIImage imageNamed:@"resign"];
input.inputView = board;
board.tf = input;

Useage2:
UITextField *input2  = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(input.frame)+20, 200, 50)];
input2.placeholder = @"请输入2";
[self.view addSubview:input2];
input2.KeyBoardStyle = TextFiledKeyBoardStyleMoney;

```
