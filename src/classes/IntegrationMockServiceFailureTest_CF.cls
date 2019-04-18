/**
 * Helper class for IntegrationTest_CF which simulates a Web Service response.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
@isTest
public class IntegrationMockServiceFailureTest_CF implements HttpCalloutMock {

    /**
     * Simulates the Web Service response for the test class.
     *
     * @param objRequest    Simulated request.
     * @return HTTP Response.
     */
    public HTTPResponse respond(HTTPRequest objRequest) {
        CalloutException objException = new CalloutException();
        objException.setMessage('This is a constructed exception!');
        throw objException;
        return null;
    }
}