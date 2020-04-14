import {api, LightningElement, track, wire} from 'lwc';
import fetchAllAccounts from '@salesforce/apex/ContinuationCallAuraLWC.fetchAllAccounts';
import { getRecord } from 'lightning/uiRecordApi';


const columns = [
    {label: 'AccountName', fieldName: 'Name', sortable: true},
    {label: 'Billing Address', fieldName: 'BillingCity', type: 'text', sortable: true},
    {label: 'Shipping Address', fieldName: 'ShippingCity', type: 'text', sortable: true},
    {label: 'Company Ext', fieldName: 'CompanyExtId__c', type: 'text', sortable: true},
    {label: 'Phone', fieldName: 'Phone', type: 'phone', sortable: true},
];

const fields = [
    'Account.Name',
    'Account.Phone',
];


export default class AccountPageAura extends LightningElement {
    @api isLoaded = false;
    @track data = [];
    @track columns = columns;
    @track account;
    @api cardName;
    @api recordId;

        @wire(fetchAllAccounts)
        wiredAccounts({data, error}) {
            if(data){
                this.data = data;
                this.isLoaded = !this.isLoaded;
            }
        };

    @wire(getRecord, { recordId: '0017F00002Q9eeTQAR', fields })
    account;
    get name() {
        debugger;
        return this.account.data.fields.Name.value;
    }
    get phone() {
        debugger;
        return this.account.data.fields.Phone.value;
    }

    async connectedCallback() {
        this.isLoaded = !this.isLoaded;
        /*fetchAllAccounts().then(result => {
            this.data = result;
            this.isLoaded = !this.isLoaded;
        }).catch(error => {
            this.isLoaded = !this.isLoaded;
        });*/
    }

}