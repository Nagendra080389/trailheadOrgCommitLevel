({
    /*
     * This method will call the Apex controller method 
     * to get the oAuth Token
     */
    getOAuthTokenHelper : function(objComponent,objHelper) {
        var strCode = objHelper.getParamterFromRequest();
        if(strCode != null)
        {
            var action = objComponent.get("c.getOAuthToken");
            action.setParams({
                'strRequestCode': strCode
            });
            // Create a callback that is executed after the server-side action returns
            action.setCallback(this, function(objResponse) {
                var strResponseState = objResponse.getState();
                if (strResponseState === $A.get("$Label.c.Success_Response_ACE")) { 
                    if(objResponse.getReturnValue() != null)
                    {
                        //Get the Utility bar item.
                        var utilityAPI = objComponent.find("utilitybar");
                        utilityAPI.openUtility();
                        objComponent.set('v.errorMessage',objResponse.getReturnValue());
                        
                    }
                    else
                    {
                        objComponent.set('v.successMessage',$A.get("$Label.c.Successfully_Authorized_ACE"));
                    }
                }
                //If resposne state is Error show the error message on UI
                else if (strResponseState === $A.get("$Label.c.Error_Response_ACE"))
                {
                    var errors = objResponse.getError();
                    if (errors) 
                    {
                        if (errors[0] && errors[0].message) 
                        {
                            objComponent.set('v.errorMessage',errors[0].message);
                        }
                    }
                }
            });
            $A.enqueueAction(action);            
        }
    },
    /*
     * This method will call the apex controller method to open the 
     * third party Login page in same window/tab.
     */
    connectHelper : function(objComponent,objHelper)
    {
        var strCode = objHelper.getParamterFromRequest();
        
        if(strCode == null)
        {
            var action = objComponent.get("c.connect");
            // Create a callback that is executed after the server-side action returns
            action.setCallback(this, function(objResponse) {
                var strResponseState = objResponse.getState();
                
                if (strResponseState ===  $A.get("$Label.c.Success_Response_ACE")) 
                { 
                    window.open(objResponse.getReturnValue(),'_top');
                }
                else if (strResponseState === $A.get("$Label.c.Error_Response_ACE")) 
                {
                    var errors = objResponse.getError();
                    if (errors) 
                    {
                        if (errors[0] && errors[0].message)
                        {
                            var utilityAPI = objComponent.find("utilitybar");
                            utilityAPI.openUtility();
                            objComponent.set('v.errorMessage',response.getReturnValue());
                            objComponent.set('v.errorMessage',errors[0].message);
                        }
                    } 
                    
                }
            });
            $A.enqueueAction(action);
        }
    },
    /*
     * This method will capture the code parameter from the 
     * Url and return the code parameter.
     */
    getParamterFromRequest : function()
    {
        var strUrl = new URL(window.location.href);
        var strCode = strUrl.searchParams.get("code");
        return strCode;
        
    }
    
})