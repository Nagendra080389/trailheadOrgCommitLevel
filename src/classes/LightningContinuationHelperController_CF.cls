/**
 * Controller class that allows the extension of other class to use on the Lightning Continuation helper.
 * <p /><p />
 * @author Raymundo Rodriguez Sansores
 */
global with sharing class LightningContinuationHelperController_CF {
    
    /**
     * Constructor of the class.
     */
    public LightningContinuationHelperController_CF() {
        System.debug('Continuation used.');
    }
}