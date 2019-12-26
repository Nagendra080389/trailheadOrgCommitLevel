/**
 * Created by nagesingh on 2/21/2018.
 Test 1
 */

public with sharing class AnimalLocator {

  public static String getAnimalNameById(Integer x){
    Http h = new Http();
    HttpRequest req = new HttpRequest();

    req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + x);

    req.setMethod('GET');

    HttpResponse res = h.send(req);
    Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
    Map<String, Object> animal = (Map<String, Object>) results.get('animal');
    
	
	
	
	  //GSON generator: Generate GSON format body
	  JSONGenerator generator = JSON.createGenerator(true);
	  generator.writeStartObject();
	  generator.writeStringField('email', 'nilson@email.com');
	  generator.writeStringField('password','nilson');
	  generator.writeEndObject();
	  String strJsonBody = generator.getAsString();

//Fire the http request for getting the access token
	  Http http = new Http();
	  HttpRequest httpRequest = new HttpRequest();
	  httpRequest.setEndpoint('https://jwtpoc.herokuapp.com/auth/login');
	  httpRequest.setMethod('POST');
	  httpRequest.setHeader('Content-Type','application/json');
	  httpRequest.setBody(strJsonBody);
	  HttpResponse httpResponse = http.send(httpRequest);
	
	  Map<String, Object> mapStrings = (Map<String, Object>)JSON.deserializeUntyped(httpResponse.getBody());

//Extract the access token
	  String strAccessToken = (String)mapStrings.get('access_token');
	
	  System.debug('strAccessToken -> '+strAccessToken);
	
	  Http http1 = new Http();
	  HttpRequest httpRequest1 = new HttpRequest();
	  httpRequest1.setEndpoint('https://jwtpoc.herokuapp.com/products');
	  httpRequest1.setMethod('GET');
	  httpRequest1.setHeader('Authorization','Bearer '+strAccessToken);
	  HttpResponse httpResponse1 = http1.send(httpRequest1);
	  System.debug(httpResponse1.getBody());
	
	
	  return (String)animal.get('name');
	  
  }
	
	
}
