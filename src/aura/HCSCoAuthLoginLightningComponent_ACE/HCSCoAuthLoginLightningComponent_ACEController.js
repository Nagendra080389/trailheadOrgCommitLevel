({ 
    /*
     * Init method of Lightning component which wil call
     * helper method to connect to third party login Page and 
     * get oAuth Token
     * 
     */ 
    doInit: function(objComponent,objEvent,objHelper) {    
      objHelper.connectHelper(objComponent,objHelper);
      objHelper.getOAuthTokenHelper(objComponent,objHelper);
        
    },
})