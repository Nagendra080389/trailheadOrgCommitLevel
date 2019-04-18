/**
 * Created by nagesingh on 4/25/2018.
 * Committed via delta change
 */

public class UserTest {

    public static List<User> users = [SELECT Id, Country FROM User WHERE Id =:UserInfo.getUserId()];
}