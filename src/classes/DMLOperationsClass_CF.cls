/**
 * This class helps to process all the DML operations, storing exceptions and avoid recursiveness.
 * <p /><p />
 * @author Raymundo Rodriguez
 */
public without sharing class DMLOperationsClass_CF {
    
    //Public variables.
    public static Boolean BOOLEAN_STOP_RECURSIVENESS = false;
    public static final Integer INTEGER_OPERATION_INSERT = 1;
    public static final Integer INTEGER_OPERATION_UPDATE = 2;
    public static final Integer INTEGER_OPERATION_UPSERT = 3;
    public static final Integer INTEGER_OPERATION_DELETE = 4;
    public static final Integer INTEGER_OPERATION_UNDELETE = 5;
    public static Map<String, Boolean> mapTriggersStatus = new Map<String, Boolean>();
    
    /**
     * Inserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF insertRecords(List<sObject> lstRecords) {
        return dmlOperation(INTEGER_OPERATION_INSERT, lstRecords, null, null, null, null, null);
    }
    
    /**
     * Inserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF insertRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail) {
        return dmlOperation(INTEGER_OPERATION_INSERT, lstRecords, boolStopSubsequentRecordsOnFail, null, null, null, null);
    }
    
    /**
     * Inserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF insertRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return dmlOperation(INTEGER_OPERATION_INSERT, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, null);
    }
    
    /**
     * Inserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF insertRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return dmlOperation(INTEGER_OPERATION_INSERT, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * Inserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF insertRecords(List<sObject> lstRecords, List<String> lstDeactivatedTriggerObjects) {
        return dmlOperation(INTEGER_OPERATION_INSERT, lstRecords, false, null, null, null, lstDeactivatedTriggerObjects);
    }
    
    /**
     * Inserts a record.
     *
     * @param objRecord    Record related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF insertRecord(sObject objRecord) {
        return insertRecords(prepareSingleRecord(objRecord));
    }
    
    /**
     * Inserts a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF insertRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return insertRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity);
    }
    
    /**
     * Inserts a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF insertRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return insertRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * Updates a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF updateRecords(List<sObject> lstRecords) {
        return dmlOperation(INTEGER_OPERATION_UPDATE, lstRecords, null, null, null, null, null);
    }
    
    /**
     * Updates a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF updateRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail) {
        return dmlOperation(INTEGER_OPERATION_UPDATE, lstRecords, boolStopSubsequentRecordsOnFail, null, null, null, null);
    }
    
    /**
     * Updates a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF updateRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return dmlOperation(INTEGER_OPERATION_UPDATE, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, null);
    }
    
    /**
     * Updates a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF updateRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return dmlOperation(INTEGER_OPERATION_UPDATE, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * Updates a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF updateRecords(List<sObject> lstRecords, List<String> lstDeactivatedTriggerObjects) {
        return dmlOperation(INTEGER_OPERATION_UPDATE, lstRecords, false, null, null, null, lstDeactivatedTriggerObjects);
    }
    
    /**
     * Updates a record.
     *
     * @param objRecord    Record related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF updateRecord(sObject objRecord) {
        return updateRecords(prepareSingleRecord(objRecord));
    }
    
    /**
     * Updates a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF updateRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail) {
        return updateRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail);
    }
    
    /**
     * Updates a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF updateRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return updateRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity);
    }
    
    /**
     * Updates a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF updateRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return updateRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * Deletes a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF deleteRecords(List<sObject> lstRecords) {
        return dmlOperation(INTEGER_OPERATION_DELETE, lstRecords, null, null, null, null, null);
    }
    
    /**
     * Deletes a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF deleteRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail) {
        return dmlOperation(INTEGER_OPERATION_DELETE, lstRecords, boolStopSubsequentRecordsOnFail, null, null, null, null);
    }
    
    /**
     * Deletes a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF deleteRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return dmlOperation(INTEGER_OPERATION_DELETE, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, null);
    }
    
    /**
     * Deletes a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF deleteRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return dmlOperation(INTEGER_OPERATION_DELETE, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * Deletes a record.
     *
     * @param objRecord    Record related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF deleteRecord(sObject objRecord) {
        return deleteRecords(prepareSingleRecord(objRecord));
    }
    
    /**
     * Deletes a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF deleteRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail) {
        return deleteRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail);
    }
    
    /**
     * Deletes a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF deleteRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return deleteRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity);
    }
    
    /**
     * Deletes a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF deleteRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return deleteRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * Undeletes a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF undeleteRecords(List<sObject> lstRecords) {
        return dmlOperation(INTEGER_OPERATION_UNDELETE, lstRecords, null, null, null, null, null);
    }
    
    /**
     * Undeletes a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF undeleteRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail) {
        return dmlOperation(INTEGER_OPERATION_UNDELETE, lstRecords, boolStopSubsequentRecordsOnFail, null, null, null, null);
    }
    
    /**
     * Undeletes a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF undeleteRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return dmlOperation(INTEGER_OPERATION_UNDELETE, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, null);
    }
    
    /**
     * Undeletes a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF undeleteRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return dmlOperation(INTEGER_OPERATION_UNDELETE, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * Undeletes a record.
     *
     * @param objRecord    Record related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF undeleteRecord(sObject objRecord) {
        return undeleteRecords(prepareSingleRecord(objRecord));
    }
    
    /**
     * Undeletes a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF undeleteRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail) {
        return undeleteRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail);
    }
    
    /**
     * Undeletes a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF undeleteRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return undeleteRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity);
    }
    
    /**
     * Undeletes a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF undeleteRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return undeleteRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * Upserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecords(List<sObject> lstRecords) {
        return dmlOperation(INTEGER_OPERATION_UPSERT, lstRecords, null, null, null, null, null);
    }
    
    /**
     * Upserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecords(List<sObject> lstRecords, List<String> lstDeactivatedTriggerObjects) {
        return dmlOperation(INTEGER_OPERATION_UPSERT, lstRecords, null, null, null, null, lstDeactivatedTriggerObjects);
    }
    
    /**
     * Upserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail) {
        return dmlOperation(INTEGER_OPERATION_UPSERT, lstRecords, boolStopSubsequentRecordsOnFail, null, null, null, null);
    }
    
    /**
     * Upserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return dmlOperation(INTEGER_OPERATION_UPSERT, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, null);
    }
    
    /**
     * Upserts a list of records.
     *
     * @param lstRecords    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecords(List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return dmlOperation(INTEGER_OPERATION_UPSERT, lstRecords, boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * Upserts a record.
     *
     * @param objRecord    Record related to the operation.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecord(sObject objRecord) {
        return upsertRecords(prepareSingleRecord(objRecord));
    }
    
    /**
     * Upserts a record.
     *
     * @param objRecord    Record related to the operation.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecord(sObject objRecord, List<String> lstDeactivatedTriggerObjects) {
        return upsertRecords(prepareSingleRecord(objRecord), lstDeactivatedTriggerObjects);
    }
    
    /**
     * Upserts a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail) {
        return upsertRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail);
    }
    
    /**
     * Upserts a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity) {
        return upsertRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity);
    }
    
    /**
     * Upserts a record.
     *
     * @param objRecord    Record related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails..
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF upsertRecord(sObject objRecord, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        return upsertRecords(prepareSingleRecord(objRecord), boolStopSubsequentRecordsOnFail, boolAddApexPageMessage, strUserFriendlyExceptionMessage, objSeverity, 
                lstDeactivatedTriggerObjects);
    }
    
    /**
     * This method prepares the list for the generic method, with one single record.
     *
     * @param objException    Exception to be processed.
     * @return List of sObject records.
     */
    public static List<sObject> prepareSingleRecord(sObject objRecord) {
        List<sObject> lstRecords = new List<sObject>();
        if(objRecord != null) {
            lstRecords.add(objRecord);
        }
        return lstRecords;
    }
    
    /**
     * This method defines if we should stop the trigger execution of an specific object.
     *
     * @param strClassName    Class of the object related to the trigger.
     * @return If the trigger must be stopped or not.
     */
    public static Boolean shouldStopTriggerExecution(String strClassName) {
        Boolean boolResult = false;
        if(String.IsNotBlank(strClassName)) {
            boolResult = mapTriggersStatus.get(strClassName);
            if(boolResult == null) {
                boolResult = false;
            }
        }
        return boolResult;
    }
    
    /**
     * Executes the request DML operation.
     *
     * @param intDMLOperation    DML operation type.
     * @param lstObjects    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails.
     * @param boolAddApexPageMessage    Indicates if we need to add an ApexPage message, in case of exception.
     * @param strUserFriendlyExceptionMessage    User friendly error message.
     * @param objSeverity    Message Severity for ApexPage Messages.
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     * @return DML Operation results wrapper.
     */
    public static DMLOperationResultClass_CF dmlOperation(Integer intDMLOperation, List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail, Boolean boolAddApexPageMessage, 
            String strUserFriendlyExceptionMessage, ApexPages.Severity objSeverity, List<String> lstDeactivatedTriggerObjects) {
        DMLOperationResultClass_CF objResults = new DMLOperationResultClass_CF();
        if(lstRecords != null && lstRecords.size() > 0) {
            
            //Setting default values.
            if(boolStopSubsequentRecordsOnFail == null) {
                boolStopSubsequentRecordsOnFail = false;
            }
            if(boolAddApexPageMessage == null) {
                boolAddApexPageMessage = false;
            }
            
            //We now define which triggers will be deactivated.
            switchTriggers(true, lstDeactivatedTriggerObjects);
            
            //We set the ApexPage Messages, if requested.
            if(boolAddApexPageMessage != null && boolAddApexPageMessage) {
                if(String.IsBlank(strUserFriendlyExceptionMessage)) {
                    strUserFriendlyExceptionMessage = Label.DMLOperationsClass_CF_OperationCompleted_CF;
                }
                if(objSeverity == null) {
                    objSeverity = ApexPages.Severity.ERROR;
                }
                ApexPages.addMessage(new ApexPages.Message(objSeverity, strUserFriendlyExceptionMessage));
            }
            
            //Now we define the DML operation.
            objResults = executeDMLOperation(intDMLOperation, lstRecords, boolStopSubsequentRecordsOnFail);
            
            //Now we reactivate the deactivated triggers.
            switchTriggers(false, lstDeactivatedTriggerObjects);
        }
        return objResults;
    }
    
    /**
     * Activates and Deactivates triggers.
     *
     * @param boolDeactivate    Deactivate triggers?
     * @param lstDeactivatedTriggerObjects    List of triggers that need to be deactivated.
     */
    private static void switchTriggers(Boolean boolDeactivate, List<String> lstDeactivatedTriggerObjects) {
        if(lstDeactivatedTriggerObjects != null) {
            for(String strClass : lstDeactivatedTriggerObjects) {
                mapTriggersStatus.put(strClass, boolDeactivate);
            }
        }
    }
    
    /**
     * Executes the requested DML operation.
     *
     * @param intDMLOperation    DML operation type.
     * @param lstObjects    Records related to the operation.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails.
     * @return DML Operation results wrapper.
     */
    private static DMLOperationResultClass_CF executeDMLOperation(Integer intDMLOperation, List<sObject> lstRecords, Boolean boolStopSubsequentRecordsOnFail) {
        DMLResultClass_CF objRecordResult;
        ErrorLogWrapperClass_CF objNewException;
        DMLOperationResultClass_CF objResults = new DMLOperationResultClass_CF();
        objResults.lstResults = new List<DMLResultClass_CF>();
        objResults.lstRecords = lstRecords;
        List<ErrorLogWrapperClass_CF> lstExceptions = new List<ErrorLogWrapperClass_CF>();
        if(intDMLOperation == INTEGER_OPERATION_INSERT || intDMLOperation == INTEGER_OPERATION_UPDATE) {
            executeInsertUpdate(intDMLOperation, boolStopSubsequentRecordsOnFail, objResults, lstExceptions, lstRecords);
        } else if(intDMLOperation == INTEGER_OPERATION_DELETE) {
            executeDelete(boolStopSubsequentRecordsOnFail, objResults, lstExceptions);
        } else if(intDMLOperation == INTEGER_OPERATION_UNDELETE) {
            executeUndelete(boolStopSubsequentRecordsOnFail, objResults, lstExceptions);
        } else if(intDMLOperation == INTEGER_OPERATION_UPSERT) {
            executeUpsert(boolStopSubsequentRecordsOnFail, objResults, lstExceptions);
        }
        
        //If there are exceptions to log, we use the Error Log class.
        if(lstExceptions.size() > 0) {
            ErrorLogClass_CF.processExceptions(lstExceptions);
        }
        return objResults;
    }
    
    /**
     * Executes the requested Insert/Update operation.
     *
     * @param intDMLOperation    DML operation type.
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails.
     * @param objResults    Results object.
     * @param lstExceptions    List of exceptions.
     * @param lstObjects    Records related to the operation.
     */
    private static void executeInsertUpdate(Integer intDMLOperation, Boolean boolStopSubsequentRecordsOnFail, DMLOperationResultClass_CF objResults, 
            List<ErrorLogWrapperClass_CF> lstExceptions, List<sObject> lstRecords) {
        DMLResultClass_CF objRecordResult;
        ErrorLogWrapperClass_CF objNewException;
            
        //Now we execute the DML operation.
        List<Database.SaveResult> lstDMLResults;
        if(intDMLOperation == INTEGER_OPERATION_INSERT) {
            lstDMLResults = Database.insert(lstRecords, boolStopSubsequentRecordsOnFail);
        } else {
            lstDMLResults = Database.update(lstRecords, boolStopSubsequentRecordsOnFail);
        }
        for(Database.SaveResult objResult : lstDMLResults) {
            objRecordResult = new DMLResultClass_CF();
            objRecordResult.boolIsSuccess = objResult.isSuccess();
            objRecordResult.objId = objResult.getId();
            objRecordResult.boolWasCreated = String.IsNotBlank(objRecordResult.objId);
            if(!objRecordResult.boolIsSuccess) {
                objRecordResult.lstErrorMessages = new List<String>();
                for(Database.Error objErrorMessage : objResult.getErrors()) {
                    
                    //We first set the error message to be returned on the results.
                    objRecordResult.lstErrorMessages.add(objErrorMessage.getMessage());
                    
                    //Now we prepare the exception.
                    prepareException(lstExceptions, objErrorMessage.getMessage(), lstRecords);
                }
            }
            objResults.lstResults.add(objRecordResult);
        }
    }
    
    /**
     * Executes the requested Delete operation.
     *
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails.
     * @param objResults    Results object.
     * @param lstExceptions    List of exceptions.
     */
    private static void executeDelete(Boolean boolStopSubsequentRecordsOnFail, DMLOperationResultClass_CF objResults, 
            List<ErrorLogWrapperClass_CF> lstExceptions) {
        DMLResultClass_CF objRecordResult;
        ErrorLogWrapperClass_CF objNewException;
            
        //Now we execute the DML operation.
        try {
            for(Database.DeleteResult objResult : Database.delete(objResults.lstRecords, boolStopSubsequentRecordsOnFail)) {
                objRecordResult = new DMLResultClass_CF();
                objRecordResult.boolIsSuccess = objResult.isSuccess();
                objRecordResult.objId = objResult.getId();
                objResults.lstResults.add(objRecordResult);
            }
        } catch(Exception objException) {
            for(sObject objRecordToDelete : objResults.lstRecords) {
                objRecordResult = new DMLResultClass_CF();
                objRecordResult.boolIsSuccess = false;
                objRecordResult.objId = objRecordToDelete.Id;
                objRecordResult.lstErrorMessages = new List<String>();
                
                //We first set the error message to be returned on the results.
                objRecordResult.lstErrorMessages.add(objException.getMessage());
                
                //Now we prepare the exception.
                prepareException(lstExceptions, objException.getMessage(), objRecordToDelete);
                objResults.lstResults.add(objRecordResult);
            }
        }
    }
    
    /**
     * Executes the requested Undelete operation.
     *
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails.
     * @param objResults    Results object.
     * @param lstExceptions    List of exceptions.
     */
    private static void executeUndelete(Boolean boolStopSubsequentRecordsOnFail, DMLOperationResultClass_CF objResults, 
            List<ErrorLogWrapperClass_CF> lstExceptions) {
        DMLResultClass_CF objRecordResult;
        ErrorLogWrapperClass_CF objNewException;
            
        //Now we execute the DML operation.
        try {
            for(Database.UndeleteResult objResult : Database.undelete(objResults.lstRecords, boolStopSubsequentRecordsOnFail)) {
                objRecordResult = new DMLResultClass_CF();
                objRecordResult.boolIsSuccess = objResult.isSuccess();
                objRecordResult.objId = objResult.getId();
                objResults.lstResults.add(objRecordResult);
            }
        } catch(Exception objException) {
            for(sObject objRecordToUndelete : objResults.lstRecords) {
                objRecordResult = new DMLResultClass_CF();
                objRecordResult.boolIsSuccess = false;
                objRecordResult.objId = objRecordToUndelete.Id;
                objRecordResult.lstErrorMessages = new List<String>();
                
                //We first set the error message to be returned on the results.
                objRecordResult.lstErrorMessages.add(objException.getMessage());
                
                //Now we prepare the exception.
                prepareException(lstExceptions, objException.getMessage(), objRecordToUndelete);
                objResults.lstResults.add(objRecordResult);
            }
        }
    }
    
    /**
     * Executes the requested Upsert operation.
     *
     * @param boolStopSubsequentRecordsOnFail    Stops the DML operation if one record fails.
     * @param objResults    Results object.
     * @param lstExceptions    List of exceptions.
     */
    private static void executeUpsert(Boolean boolStopSubsequentRecordsOnFail, DMLOperationResultClass_CF objResults, 
            List<ErrorLogWrapperClass_CF> lstExceptions) {
            
        //Now we execute the DML operation.
        List<sObject> lstRecordsToInsert = new List<sObject>();
        List<sObject> lstRecordsToUpdate = new List<sObject>();
        for(sObject objRecordToSplit : objResults.lstRecords) {
            if(objRecordToSplit.Id == null) {
                lstRecordsToInsert.add(objRecordToSplit);
            } else {
                lstRecordsToUpdate.add(objRecordToSplit);
            }
        }
        if(lstRecordsToInsert.size() > 0) {
            executeInsertUpdate(INTEGER_OPERATION_INSERT, boolStopSubsequentRecordsOnFail, objResults, lstExceptions, lstRecordsToInsert);
        }
        if(lstRecordsToUpdate.size() > 0) {
            executeInsertUpdate(INTEGER_OPERATION_UPDATE, boolStopSubsequentRecordsOnFail, objResults, lstExceptions, lstRecordsToUpdate);
        }
    }
    
    /**
     * Adds exception to list of existing exceptions.
     *
     * @param lstExceptions Current List of exceptions to which the new exception is to be added.
     * @param errorMessage  New exception message.
     * @param objRecord     Record that caused the exception.
     */
    private static void prepareException(List<ErrorLogWrapperClass_CF> lstExceptions, String errorMessage, sObject objRecord) {
        if(objRecord != null) {
            List<sObject> lstRecords = prepareSingleRecord(objRecord);
            prepareException(lstExceptions, errorMessage, lstRecords);
        }
    }

    /**
     * Adds exception to list of existing exceptions.
     *
     * @param lstExceptions Current List of exceptions to which the new exception is to be added.
     * @param errorMessage  New exception message.
     * @param lstRecords    Records that caused the exception.
     */
    private static void prepareException(List<ErrorLogWrapperClass_CF> lstExceptions, String errorMessage, List<sObject> lstRecords) {
        if(lstExceptions != null) {
            ErrorLogWrapperClass_CF objNewException = new ErrorLogWrapperClass_CF();
            objNewException.objException = new DmlException(errorMessage);
            objNewException.objClass = lstRecords;
            lstExceptions.add(objNewException);
        }
    }
}