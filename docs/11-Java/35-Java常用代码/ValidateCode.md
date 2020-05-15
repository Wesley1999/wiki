# ValidateCode

可用于生成这样的验证码：
![](https://oss-pic.wangshaogang.com/1586691188534-4cc079cb-f147-4dc6-a7af-a6737d96762d.png)

该jar包在maven仓库中是没有的，下载地址：[https://oss-lib.wangshaogang.com/ValidateCode.jar](https://oss-lib.wangshaogang.com/ValidateCode.jar)

参考代码：
```java
@RequestMapping("get_verification_code")
public void getVerificationCode(HttpSession session, HttpServletResponse response,
                            @RequestParam(defaultValue = "100") int width, @RequestParam(defaultValue = "30") int height,
                            @RequestParam(defaultValue = "4") int codeCount, @RequestParam(defaultValue = "6") int lineCount) throws IOException {
    ValidateCode validateCode = new ValidateCode(width, height, codeCount, lineCount);
    String code = validateCode.getCode().toLowerCase();
    System.out.println("验证码是：" + code);
    session.setAttribute(SessionKeyConst.VERIFICATION_CODE, code);
    validateCode.write(response.getOutputStream());
}
```