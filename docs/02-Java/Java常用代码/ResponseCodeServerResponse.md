# ResponseCodeServerResponse

```java
public class ResponseCodeConst {
    public static final Integer SUCCESS = 0;
    public static final Integer WRONG_PASSWORD = 101;

    public static Map<Integer, String> responseMessage = new HashMap<Integer, String>() {{
        put(WRONG_PASSWORD, "The password is wrong.");    // 密码错误

    }};

    public static String getResponseMessageByResponseCode(Integer responseCode) {
        return responseMessage.get(responseCode);
    }
}
```
```java
@Getter
@JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
public class ServerResponse<T> implements Serializable {
    private int status;
    private String msg;
    private T data;

    private ServerResponse(int status) {
        this.status = status;
    }

    private ServerResponse(int status, String msg) {
        this.status = status;
        this.msg = msg;
    }

    private ServerResponse(int status, T data) {
        this.status = status;
        this.data = data;
    }

    public static <T> ServerResponse<T> createSuccessResponse() {
        return new ServerResponse<>(ResponseCodeConst.SUCCESS);
    }

    public static <T> ServerResponse<T> createSuccessResponse(T data) {
        return new ServerResponse<>(ResponseCodeConst.SUCCESS, data);
    }

    public static <T> ServerResponse<T> createErrorResponse(Integer responseCode) {
        return new ServerResponse<>(responseCode, ResponseCodeConst.getResponseMessageByResponseCode(responseCode));
    }

    public boolean whetherSuccess() {
        return this.status == ResponseCodeConst.SUCCESS;
    }
}
```