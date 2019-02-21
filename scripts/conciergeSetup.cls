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

// publish the articles
for (Knowledge__ka ka:[select id from Knowledge__ka]){
    KbManagement.PublishingService.publishArticle(ka.Id, true);
}

// assign them to data categories
List<Knowledge__DataCategorySelection> DCs = new List<Knowledge__DataCategorySelection>();
for (Knowledge__kav kav:[select id from Knowledge__kav]){
    DCs.add( new Knowledge__DataCategorySelection(ParentId = kav.Id, dataCategoryGroupName = 'All', dataCategoryName='All'));
}
insert DCs;