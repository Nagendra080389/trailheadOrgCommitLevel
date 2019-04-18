/**
 * Created by nagesingh on 4/25/2018.
 */

public class UserTestModified {

    public static List<User> users = getCurrentUser();


    private static List<User> getCurrentUser(){
        if(users == null){
            return [SELECT Id, Country FROM User WHERE Id =:UserInfo.getUserId()];
        }else {
            return users;
        }
    }
}