# 转为url参数

```js
/**
 * 转换为url参数
 * @param key 参数名
 * @param value 参数值
 * @param data 已有的数据，可以为空，或者是上次调用此函数的返回值
 * @returns {string} 格式：key1=value1&key2=value2，返回值可以直接直接或为http请求的参数（GET或POST均可）
 */
function parseParameter(key, value, data) {
    if (key == null) {
        alert("key不能为null")
    }
    if (value == null || value === "" || typeof(value) == "undefined") {
        return data;
    }
    value = encodeURIComponent(value)
    if (data == null || data === "") {
        return key + "=" + value;
    } else {
        return data + "&" + key + "=" + value;
    }
}

/**
 * 将整个map转换为url参数，依赖parseParameter()函数
 * @param paramsMap 键值对形式的参数，值也可以是数组
 * @returns {string} 格式：key1=value1&key2=value2，返回值可以直接直接或为http请求的参数（GET或POST均可）
 */
function parseParameterByMap(paramsMap) {
    let data = "";
    if (typeof(paramsMap) == "undefined") {
        return data;
    }
    for (let [key, value] of paramsMap) {
        if (Array.isArray(value)) {
            value.forEach(function(v) {
                data = parseParameter(data, key, v);
            });
        } else {
            data = parseParameter(data, key, value);
        }
    }
    return data;
}
```