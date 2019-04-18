/**
 * Created by nagesingh on 8/17/2018.
 * Class Name : JsonServiceTest_ACE
 */

@IsTest
public class JsonServiceTest_ACE implements HttpCalloutMock {

    private  String strResponseBody;

    public JsonServiceTest_ACE(String strBody){
        this.strResponseBody = strBody;
    }


    public HTTPResponse respond(HTTPRequest objRequest) {
        HttpResponse objResponse = new HttpResponse();
        objResponse.setHeader('Content-Type', 'application/json');
        objResponse.setBody(strResponseBody);
        objResponse.setStatusCode(200);
        return objResponse;
    }
}