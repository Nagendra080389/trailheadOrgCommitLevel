<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Test_Email</fullName>
        <description>Test Email</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MarketingProductInquiryResponse</template>
    </alerts>
    <alerts>
        <fullName>tesrSalesRepRejected</fullName>
        <description>tesrSalesRepRejected</description>
        <protected>false</protected>
        <recipients>
            <recipient>nagendra@deloitte.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/testSalesRepTemplate</template>
    </alerts>
    <fieldUpdates>
        <fullName>PendingAction</fullName>
        <field>Type</field>
        <literalValue>Pending</literalValue>
        <name>PendingAction</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Type_Field_as_Customer</fullName>
        <field>Type</field>
        <literalValue>Customer</literalValue>
        <name>Type Field as Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Type_field_back_to_Prospect</fullName>
        <field>Type</field>
        <literalValue>Prospect</literalValue>
        <name>Type field back to &apos;Prospect&apos;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>any_name</fullName>
        <actions>
            <name>Test_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.BillingCity</field>
            <operation>equals</operation>
            <value>Bengaluru</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
