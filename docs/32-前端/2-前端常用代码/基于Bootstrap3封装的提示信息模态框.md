# 基于Bootstrap3封装的提示信息模态框

```js
/**
 * 依赖jQuery和BootStrap3（不支持Bootstrap4）
 * 调用时再body标签的最后生成结点，点击确定200ms后删除（这个值如果设置的太小，会导致动画无法正常显示）
 * @param content 模态框提示内容
 * @param confirmHandle 回调函数，在点击模态框确定按钮后执行
 */
function showInfoModal(content="Success", confirmHandle) {
    $("body").append('<div class="modal fade" id="info_modal" tabindex="-1" aria-hidden="true" data-backdrop="static">\n' +
        '    <div class="modal-dialog" role="document">\n' +
        '        <div class="modal-content">\n' +
        '            <div class="modal-header">\n' +
        '                <h4 class="modal-title" >Info</h4>\n' +
        '            </div>\n' +
        '            <div class="modal-body">\n' +
        '                <div id="info_content">'+content+'</div>\n' +
        '            </div>\n' +
        '            <div class="modal-footer">\n' +
        '                <button type="button" class="btn btn-primary" style="float: right" id="info_modal_confirm_button">Confirm</button>\n' +
        '            </div>\n' +
        '        </div>\n' +
        '    </div>\n' +
        '</div>');
    $("#info_modal").modal("show");
    $("#info_modal_confirm_button").click(function () {
        $("#info_modal").modal("hide");
        setTimeout(function(){
            $("#info_modal").remove();
            if (afterConfirm != null) {
                afterConfirm();
            }
        }, 200);
    })
}
```