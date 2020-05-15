# Ajax与Json

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册</title>
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <script src="js/jquery.serialize-object.min.js"></script>
    <script type="text/javascript">
	$(function () {
		$.ajax({
			type: "POST",
			url: "/logup.action",
			data: JSON.stringify($('#form1').serializeObject()),
			contentType: "application/json;charset=UTF-8",// 发送数据的格式
			dataType: "json",// 回调
			error: function () {
				alert("请求失败");
			},
			success: function (returnData) {
				alert(returnData.logupResult)
			}
		})
	})
</script>
</head>
<body>
<form id="form1">
    邮箱：<input type="text" name="email"/><br>
    用户名：<input type="text" name="username"/><br>
    密码：<input type="password" name="password"/><br>
    确认密码：<input type="text" placeholder="不用输入"/>
    <input type="button" value="注册" onclick="login()"/>
</form>
</body>
</html>
```