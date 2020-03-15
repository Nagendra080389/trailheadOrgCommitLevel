public class ContactSearch {

    // This method is used for contact Search
    public static List<Contact> searchForContacts(String input1, String input2) {
        List<Contact> contactList = [Select ID, Name FROM Contact where Contact.LastName = :input1 AND Contact.MailingPostalCode = :input2];
        return contactList;
    }

}