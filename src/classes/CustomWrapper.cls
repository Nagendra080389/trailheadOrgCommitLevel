/**
 * Created by nagesingh on 8/6/2018.
 */


public class CustomWrapper {

  @AuraEnabled
  private Integer albumId {get;set;}
  @AuraEnabled
  private Integer id {get;set;}
  @AuraEnabled
  private String title {get;set;}
  @AuraEnabled
  private String url {get;set;}
  @AuraEnabled
  private String thumbnailUrl {get;set;}

  public CustomWrapper(Integer albumId, Integer id, String title, String url, String thumbnailUrl){
    this.albumId = albumId;
    this.id = id;
    this.title = title;
    this.url = url;
    this.thumbnailUrl = thumbnailUrl;
  }

}