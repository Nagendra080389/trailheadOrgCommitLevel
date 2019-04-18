/**
 * Helper class for IntegrationTest_CF which simulates a Web Service response.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
@isTest
public class IntegrationMockServiceTest_CF implements HttpCalloutMock {

    /**
     * Simulates the Web Service response for the test class.
     *
     * @param objRequest    Simulated request.
     * @return HTTP Response.
     */
    public HTTPResponse respond(HTTPRequest objRequest) {
        HttpResponse objResponse = new HttpResponse();
        objResponse.setHeader('Content-Type', 'application/json');
        objResponse.setBody('{"test":"test"}');
        objResponse.setStatusCode(200);
        return objResponse;
    }
}