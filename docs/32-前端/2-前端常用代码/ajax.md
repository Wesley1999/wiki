# ajax

```js
$.ajax({
    url: '/api/test.action',
    data: parseParameterByMap(paramsMap),
    type: "POST",
    success: function (returnData) {
        if (returnData.status === 0) {

        }
    },
    error: function () {

    }
})
```