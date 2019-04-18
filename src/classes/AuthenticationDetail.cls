public class AuthenticationDetail{
  /*End point Url to web service callout*/
  private final static String ENP_POINT_URL = 'https://login.salesforce.com/services/oauth2/token';
  //For development and production https://login.salesforce.com/services/oauth2/token
  //And for sandbox https://test.salesforce.com/services/oauth2/token
  private final static String REQUEST_BODY = 'grant_type=password&client_id={0}&client_secret={1}&username={2}&password={3}';
  private final static String USERNAME = 'nagendra@deloitte.com';
  private final static String PASSWORD = 'Developer!7d8EtR2wOaPZ4BB48sgeibOSl';
  private final static String CONSUMER_KEY = '3MVG9d8..z.hDcPLDlm9QqJ3hRU5D_hIE_kPN7ijZpXjrT6QJTmSPUD2M0ubadFqF19_HhYPeDQyi1ypTdY5w';
  private final static String CONSUMER_SECRET = '921256947869178766';

  /*To generate Access token Method*/
  private static OAuth getAccessToken(){
    try{
      HttpRequest req = new HttpRequest();
      req.setEndpoint(ENP_POINT_URL);
      req.setMethod('POST'); 
      Blob headerValue = Blob.valueOf(USERNAME + ':' + PASSWORD);
      String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
      req.setHeader('Authorization', authorizationHeader); 
      req.setBody(String.format(REQUEST_BODY ,new string[]{CONSUMER_KEY,CONSUMER_SECRET,
                                                           USERNAME,PASSWORD}));
      req.setTimeout(60000);
      Http http = new Http();
      HttpResponse res = http.send(req);
      System.debug('res.getbody() - >' + res.getbody());

      OAuth objAuthenticationInfo = (OAuth)JSON.deserialize(res.getbody(), OAuth.class);
      return objAuthenticationInfo;
    }catch(CallOutException ce){
      throw ce;
    }

  }

  /*To get Access token property*/
  public static OAuth authenticationDetail{
    get{
      if(authenticationDetail == null){
        authenticationDetail = getAccessToken();
      }
      return authenticationDetail;
    }set;
  }

  /*To get aouthentication detail Wrapper*/
  public class OAuth{
    public String id{get;set;}
    public String issued_at{get;set;}
    public String instance_url{get;set;}
    public String signature{get;set;}
    public String access_token{get;set;} 
  } 
}