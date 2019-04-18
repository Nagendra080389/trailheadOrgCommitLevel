/**
 * This class authenticates a JWT mulesoft endpoint and fetches the data.
 * <p /><p />
 * @author nagesingh
 */
public without sharing class JWTAuthentication {
	
	// This class is to test incremental deployment 2
	public static List<String> fetchEmployees() {
		Map<String,String> mapHeaderValues = new Map<String,String>();
		mapHeaderValues.put('client_secret', 'iMNR_xkBfvx4DWzef8DCURZ1Et4X_lA');
		mapHeaderValues.put('client_id', '0oag51h3ld9F87Rt90h7');
		IntegrationWrapperClass_CF objIntegrationWrapperClass = IntegrationClass_CF.synchronousCallout('JWTTokenMuleSoft', null, null, mapHeaderValues);
		if (objIntegrationWrapperClass.intResponseStatusCode == 200) {
			Map<String,Object> mapResults = (Map<String,Object>) JSON.deserializeUntyped(objIntegrationWrapperClass.strResponseBody);
			
			mapHeaderValues.clear();
			mapHeaderValues.put('access_token',(String)mapResults.get('accessCode'));
			String strBody = 'access_token='+(String)mapResults.get('accessCode');
			objIntegrationWrapperClass = IntegrationClass_CF.synchronousCallout('JWTEndpointMuleSoft', null, null, mapHeaderValues);
			
			List<Object> lstResults = (List<Object>) JSON.deserializeUntyped(objIntegrationWrapperClass.strResponseBody);
			
			for (Object mapEachResult : lstResults){
				System.debug(((Map<String, Object>)mapEachResult).get('name'));
				System.debug(((Map<String, Object>)mapEachResult).get('age'));
			}
		}
		
		return null;
	
	}
	
	public static void testMain(){
	
	}
	
	public static void testMain2(){
	
	}
}