/**
 * Created by nagesingh on 8/7/2018.
 */

public class GitHubUserRepo {
    @AuraEnabled
    private Integer Id { get; set; }
    @AuraEnabled
    private String name { get; set; }
    @AuraEnabled
    private String login { get; set; }
    @AuraEnabled
    private String avatar_url { get; set; }

    public GitHubUserRepo(Integer Id, String name, String login, String avatar_url) {
        this.Id = Id;
        this.name = name;
        this.login = login;
        this.avatar_url = avatar_url;
    }
}