permissionSet ps = [select id from permissionSet where name = 'solutions'];

list<string> appNames = new list<string> {'Concur', 'Google Calendar', 'GDrive', 'Gmail', 'GoToMeeting'}; 
List<ConnectedApplication> apps = [select id, name from ConnectedApplication where Name in:appNames];

List<SetupEntityAccess> SEAs = new List<SetupEntityAccess>();
for (ConnectedApplication app:apps){
    SEAS.add(new SetupEntityAccess(ParentId=ps.Id, SetupEntityId=app.Id));
}

insert SEAs;