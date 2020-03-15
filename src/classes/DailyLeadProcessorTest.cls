@isTest
private class DailyLeadProcessorTest {
    @testSetup
    static void setup() {

    }
    static testmethod void testDailyLeadProcessorScheduledJob() {
        String testHSONString = '{"request_tracking_id":"54097","customer_id":"195771453016","reference_id":"a624C0000004FqTQAU"}';
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(testHSONString);
        String request_tracking_id = (String) responseMap.get('request_tracking_id');
        String customer_id = (String) responseMap.get('customer_id');
        String reference_id = (String) responseMap.get('reference_id');
        System.debug(request_tracking_id);
        System.debug(customer_id);
        System.debug(reference_id);
    }
}