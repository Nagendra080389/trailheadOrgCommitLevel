/**
 * Created by nagesingh on 2/2/2018.
 */

public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer firstParameter, String secondParameter){
        List<Contact> contacts = new List<Contact>();
        Contact contact = null;
        for (Integer i = 0; i < firstParameter; i++) {
            contact = new Contact();
            contact.FirstName = 'Test '+i;
            contact.LastName = secondParameter;
            contacts.add(contact);
        }
        return contacts;
    }
}