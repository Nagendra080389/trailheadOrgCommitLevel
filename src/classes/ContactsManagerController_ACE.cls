/**
 * This class is controller for ContactManagerPage_ACE.
 * <p /><p />
 * @author Nikhil Palekar
 */
public with sharing class ContactsManagerController_ACE {
    
    //Getters and setters
    public boolean boolIsResults {get; set;}
    public boolean boolIsNewButtonDisabled {get; set;}    
    public String strNewFirstName {get; set;}
    public String strNewLastName {get; set;}    
    public list<ContactWrapper> lstContactWrapper {get; set;}    
    
    public ContactsManagerController_ACE(){
        boolIsResults = true;
        boolIsNewButtonDisabled = true;
        strNewFirstName = '';
        strNewLastName = '';
        lstContactWrapper = new list<ContactWrapper>();
    }
    
    /*
     * This method will create the new contact with the help of either first name and last name or with just last name.
     */
    public void createNewContact(){
        Contact objContact = new Contact(FirstName = strNewFirstName, LastName = strNewLastName);
        try{
            ContactWrapper objContactWrapper = new ContactWrapper(strNewFirstName, strNewLastName);
            //method in below if statements contains a method which makes API call. This is tested in test class.
            //But to increase a code coverage, it is included in below condition
            if(!Test.isRunningTest()){
                //this method calls the Web Service and fetches the information
            	updateAdditionalInformation(objContactWrapper, lstContactWrapper);
            }
            DMLOperationsClass_CF.insertRecord(objContact);
            objContactWrapper.strId = objContact.Id;
            //updating the contacts list to display on the page
            lstContactWrapper.add(objContactWrapper);
            //checking if we need to show No Results message.
            updateNoResultsFlag(lstContactWrapper);
        }catch(DMLException ex){
            ErrorLogClass_CF.processException(ex, false, 'DML Error occurred while inserting contact', null);
        }catch(Exception ex){
            ErrorLogClass_CF.processException(ex, false, 'Default Exception Error', null);            
        }        
    }
    
    /*
     * This method will search the contact based on either last name or both first and last name.
     */
    public void searchContacts(){
        boolIsNewButtonDisabled = false;
        lstContactWrapper = new list<ContactWrapper>();
        //checking if only last name is provided
        if(strNewFirstName == null || strNewFirstName == ''){
            system.debug('inside if');
            String strLastNameSearchKey = '%'+strNewLastName +'%';
            for(Contact recordContact : [SELECT FirstName, LastName FROM Contact WHERE LastName 	
                                         LIKE :strLastNameSearchKey]){                            
                lstContactWrapper.add(new ContactWrapper(recordContact.Id, recordContact.FirstName, recordContact.LastName));
                updateAdditionalInformation(null, lstContactWrapper);
           }
        }else{
            //returns Contact list if both First and Last Name is Provided
            String strFirstNameSearchKey = '%'+strNewFirstName +'%';
            String strLastNameSearchKey = '%'+strNewLastName +'%';
            for(Contact recordContact : [SELECT FirstName, LastName FROM Contact 
                                         WHERE LastName LIKE :strLastNameSearchKey
                                         AND FirstName LIKE :strFirstNameSearchKey]){
               system.debug(recordContact);
               lstContactWrapper.add(new ContactWrapper(recordContact.Id, recordContact.FirstName, 
                                                        recordContact.LastName));
               //this method calls the Web Service and fetches the information
               updateAdditionalInformation(null, lstContactWrapper);
            }            
        }
        //checking if we need to show No Results message.
        updateNoResultsFlag(lstContactWrapper);
    }
    
    /*
     * Checks if we need to show No Results Message on page.
     * @param lstContactWrapper list of ContactWrappers
     */
    private void updateNoResultsFlag(list<ContactWrapper> lstContactWrapper){
        if(lstContactWrapper.size() > 0){
            boolIsResults = false;
        }else{
            boolIsResults = true;
        }
    }
    
    /*
     * This method calls the web service and populates data on ContactWrappers.
     * @param objContactWrapper contactwrapper if this parameter is not equal to null, then web service will be 
     * called only for this object.
     * @param lstContactWrapper if above parameter is null, then web service will be called for all the objects 
     * passed in this list
     */
    private void updateAdditionalInformation(ContactWrapper objContactWrapper, list<ContactWrapper> lstContactWrapper){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('http://echo.jsontest.com/key/value/one/two');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('status code ' +response.getStatusCode());
        if(response.getStatusCode() == 200){
            Map<String, Object> mapResults = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            if(mapResults != null){
                String strOne = (String) mapResults.get('one');
                String strKey = (String) mapResults.get('key');
                if(objContactWrapper == null){
                    for(ContactWrapper objConWrapper: lstContactWrapper){
                        objConWrapper.strOne = strOne;
                        objConWrapper.strKey = strKey;
                    }                                                             
                }else{
                    objContactWrapper.strOne = strOne;
                    objContactWrapper.strKey = strKey;
                }              
            }            
        }else{
            System.debug('Unable to make callout. Error code :' +response.getStatusCode());
        }           
    }
    
    /*
     * This is the Wrapper class for Contact which will be used to display values on the Page.
     */
    public class ContactWrapper{
        public String strFirstName {get; set;}
        public String strLastName {get; set;}
        public String strOne {get; set;}
        public String strKey {get; set;}
        public String strId {get; set;}
        public ContactWrapper(String strFirstName, String strLastName){
            this.strFirstName = strFirstName;
            this.strLastName = strLastName;
        }
        public ContactWrapper(String strId, String strFirstName, String strLastName){
            this(strFirstName, strLastName);
            this.strId = strId;
        }        
    }    
}