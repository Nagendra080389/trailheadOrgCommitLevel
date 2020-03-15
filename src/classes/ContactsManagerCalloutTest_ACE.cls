/**
 * Mock Class for testing Web Service Call.
 * <p /><p />
 * @author Nikhil Palekar
 */
@isTest
public class ContactsManagerCalloutTest_ACE implements HttpCalloutMock {
    /**
     * Simulates the Web Service response for the test class.
     *
     * @param objRequest Simulated request.
     * @return HTTP Response.
     */
    public HTTPResponse respond(HTTPRequest objRequest) {
        HttpResponse objResponse = new HttpResponse();
        objResponse.setHeader('Content-Type', 'application/json');
        objResponse.setBody('{"one": "two","key": "value"}');
        objResponse.setStatusCode(200);
        return objResponse;
    }
}