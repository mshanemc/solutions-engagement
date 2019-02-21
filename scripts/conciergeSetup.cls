// update some Concierge settings
list<cncrgdemo__Concierge_Settings__c> settings = [select id, name, cncrgdemo__Value__c from cncrgdemo__Concierge_Settings__c];
for (cncrgdemo__Concierge_Settings__c setting:settings) {
    if (setting.name == 'Background file name for App') {
        setting.cncrgdemo__Value__c = 'Bridge';
    } else if (setting.name == 'Display Company Logo') {
        setting.cncrgdemo__Value__c = 'false';
    }
}
update settings;

cncrgdemo__Search_Types_Settings__c x = new cncrgdemo__Search_Types_Settings__c();
x.cncrgdemo__Active__c = true;
x.Name = 'Concierge';
x.cncrgdemo__Article_Type_API_Name__c = 'Concierge';
x.cncrgdemo__Field_To_Display__c = 'Summary,';
insert x;

// put the contact on our user
contact c = new contact(FirstName = 'Jenny', LastName = 'Nunez', Email = 'shane.mclaughlin@salesforce.com', cncrgdemo__UserId__c = UserInfo.getUserId());
insert c;



// let's have some ticket history
List<case> cases = new List<case>();
cases.add(new case(Subject = 'Laptop Replacement', ContactId = c.Id, Status='Closed', Origin='Concierge'));
cases.add(new case(Subject = 'Badge Renewal', ContactId = c.Id, Status='Closed', Origin='Concierge'));
cases.add(new case(Subject = 'Address Change', ContactId = c.Id, Status='Closed', Origin='Concierge'));
cases.add(new case(Subject = 'VPN problems', ContactId = c.Id, Status='Closed', Origin='Concierge'));
cases.add(new case(Subject = 'Beneficiary Changes (new baby!)', ContactId = c.Id, Status='Closed', Origin='Concierge'));
cases.add(new case(Subject = 'Starting maternity leave', ContactId = c.Id, Status='Closed', Origin='Concierge'));
insert cases;

// get record type
Id ConciergeRT = Schema.SObjectType.Knowledge__kav.getRecordTypeInfosByDeveloperName().get('Concierge').getRecordTypeId();

List<Knowledge__kav> kavs = [select id, recordTypeId, PublishStatus from Knowledge__kav];
for (Knowledge__kav ka:kavs){
    ka.recordTypeId = ConciergeRT;
}
update kavs;

// publish the articles
for (Knowledge__ka ka:[select id from Knowledge__ka]){
    KbManagement.PublishingService.publishArticle(ka.Id, true);
}