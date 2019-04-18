/**
 * Helper class for IntegrationTest_CF which simulates a Web Service response (long).
 * <p /><p />
 * @author Raymundo Rodriguez
 */
@isTest
public class IntegrationMockServiceLongRequestTest_CF implements HttpCalloutMock {

    /**
     * Simulates the Web Service response for the test class.
     *
     * @param objRequest    Simulated request.
     * @return HTTP Response.
     */
    public HTTPResponse respond(HTTPRequest objRequest) {
        HttpResponse objResponse = new HttpResponse();
        objResponse.setHeader('Content-Type', 'application/json');
        String strLongRequest = '';
        for(Integer intCounter = 0 ; intCounter < 2000; intCounter++) {
            strLongRequest = strLongRequest + 'swat';
        }
        objResponse.setBody(strLongRequest);
        objResponse.setStatusCode(200);
        return objResponse;
    }
}