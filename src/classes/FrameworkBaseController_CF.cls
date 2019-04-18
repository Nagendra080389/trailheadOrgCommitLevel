/**
 * Support class for Custom Framework operations.
 * <p /><p />
 * @author Gabriel Coronel
 */
public with sharing class FrameworkBaseController_CF extends StaticVariablesClass_CF {
    
    /**
     * Constructor fo the class.
     */
    public FrameworkBaseController_CF(ApexPages.StandardController controller) {}
    
    /**
     * Constructor fo the class.
     */
    public FrameworkBaseController_CF() {}

    /**
     * Obtain elements from Keyboard Shortcuts.
     */
    public Map<String, String> mapAvailableKeyboardShortcuts {
        get {
            Map<String, String> mapResult = new Map<String, String>();
            for(KeyboardShortcuts_CF__c objKeyboardShortcuts : KeyboardShortcuts_CF__c.getAll().values()) {
                if(String.IsNotBlank(objKeyboardShortcuts.JSCode_CF__c)) {
                    mapResult.put(objKeyboardShortcuts.Name, objKeyboardShortcuts.JSCode_CF__c);
                }
            }
            return mapResult;
        }
    }
}