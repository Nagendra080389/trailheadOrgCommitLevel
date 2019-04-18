/**
 * Created by nagesingh on 7/30/2018.
 */

public class DataFromServerController {

  @AuraEnabled
  public static Map<Id, Opportunity> getOpportunity (){
    Map<Id, Opportunity> opportunity = new Map<Id, Opportunity>();
    try{
      System.debug('Get Opportunity Called');

      opportunity = new Map<Id, Opportunity>([SELECT Id, Name, Amount, (SELECT Id, Name, Quantity, Product2.Name from OpportunityLineItems) FROM Opportunity]);

    } catch (Exception ex){

    }

    return opportunity;

  }



  @AuraEnabled
  public static String getAmountSign (){
    return Label.AmountSign;

  }

  @AuraEnabled
  public static String getBaseUrl (){
    return Url.getSalesforceBaseUrl().toExternalForm();

  }

  @AuraEnabled
  public static List<GitHubUserRepo> customWrappersList (){
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    //request.setEndpoint('callout:GithubAPI');
    request.setEndpoint('https://avatars3.githubusercontent.com/u/6088582?v=4');
    request.setMethod('GET');
    HttpResponse response = http.send(request);
    // If the request is successful, parse the JSON response.
    List<GitHubUserRepo> gitHubUserRepos = new List<GitHubUserRepo>();
    if (response.getStatusCode() == 200) {

      // Deserialize the JSON string into collections of primitive data types.
      List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
      for(Object obj : results){
        System.debug('obj - > '+obj);
        Map<String,Object> mp_StrObj = (Map<string,Object>)obj;
        String branchName = (String)mp_StrObj.get('name');
        Map<String,Object> ownerMap = (Map<string,Object>) mp_StrObj.get('owner');
        String login = (String)ownerMap.get('login');
        String avatar_url = (String)ownerMap.get('avatar_url');
        gitHubUserRepos.add(new GitHubUserRepo(null, branchName, login, avatar_url));

      }
      return gitHubUserRepos;

    }

    return null;

  }
}