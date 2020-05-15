# AliyunOSS

依赖：
```xml
<dependency>
    <groupId>com.aliyun.oss</groupId>
    <artifactId>aliyun-sdk-oss</artifactId>
    <version>3.8.0</version>
</dependency>
```

下面是我封装的WebDAVUtil，endpoint、accessKeyId、accessKeySecret、bucketName和最后的return需要做出相应修改。
```java
import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.UploadFileRequest;
import java.io.File;

public class MyUploadUtil {

    /**
     *
     * @param filePath 要上传的文件路径，如果不存在，会上传一个空文件
     *                 该文件名也是保存在阿里云对象存储中的文件名，如果重复则覆盖
     * @return 外部访问/下载链接
     */
    public static String upload(String filePath) {
        String endpoint = "http://oss-cn-shanghai.aliyuncs.com";
        String accessKeyId = "*******************************";
        String accessKeySecret = "*******************************";
        String bucketName = "pic-wsg";
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
        File file = new File(filePath);
        String fileName = file.getName();

        try {
            UploadFileRequest uploadFileRequest = new UploadFileRequest(bucketName, fileName);
            // The local file to upload---it must exist.
            uploadFileRequest.setUploadFile(filePath);
            // Sets the concurrent upload task number to 5.
            uploadFileRequest.setTaskNum(10);
            // Sets the part size to 1MB.
            uploadFileRequest.setPartSize(1024 * 1024 * 1);
            // Enables the checkpoint file. By default it's off.
            uploadFileRequest.setEnableCheckpoint(true);

            ossClient.uploadFile(uploadFileRequest);
//            UploadFileResult uploadResult = ossClient.uploadFile(uploadFileRequest);
//            CompleteMultipartUploadResult multipartUploadResult = uploadResult.getMultipartUploadResult();
//            System.out.println(multipartUploadResult.getETag());

        } catch (OSSException oe) {
            System.out.println("Caught an OSSException, which means your request made it to OSS, "
                    + "but was rejected with an error response for some reason.");
            System.out.println("Error Message: " + oe.getErrorMessage());
            System.out.println("Error Code:       " + oe.getErrorCode());
            System.out.println("Request ID:      " + oe.getRequestId());
            System.out.println("Host ID:           " + oe.getHostId());
        } catch (ClientException ce) {
            System.out.println("Caught an ClientException, which means the client encountered "
                    + "a serious internal problem while trying to communicate with OSS, "
                    + "such as not being able to access the network.");
            System.out.println("Error Message: " + ce.getMessage());
        } catch (Throwable e) {
            e.printStackTrace();
        } finally {
            ossClient.shutdown();
        }
        return "https://oss-pic.wangshaogang.com/" + fileName;
    }
}
```