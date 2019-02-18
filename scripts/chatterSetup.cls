delete [select id from feeditem];

CollaborationGroup salesGroup = [select id from CollaborationGroup where name = 'Sales Support'];
CollaborationGroup remoteGroup = [select id from CollaborationGroup where name = 'Remote Workers'];

User Willy = [select Id, Name FROM User WHERE Name = 'William Loman'];
User Jesse = [select Id, Name FROM User WHERE Name = 'Jesse Sanchez'];

insert new CollaborationGroupMember(CollaborationGroupId = salesGroup.Id, MemberId= Willy.Id);

ContentDocument desk = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument WHERE Title = 'desk'];

feeditem salesQuestion = new feeditem();
salesQuestion.body = 'Do we have the updated customer process documentation?';
salesQuestion.CreatedById = Willy.Id;
salesQuestion.parentId = salesGroup.Id;
salesQuestion.createdDate = system.now().addHours(-14);
insert salesQuestion;

// ask a question in the remote workers group?
feeditem remoteQuestion = new feeditem();
remoteQuestion.body = 'I\'m really struggling with posture since coming back to work.  I miss my sit/stand desk back at HQ.  What do you use in your home office?';
remoteQuestion.parentId = remoteGroup.Id;
remoteQuestion.createdDate = system.now().addHours(-1);
insert remoteQuestion;

FeedComment remoteResponse = new FeedComment();
remoteResponse.CommentBody = 'I have on of these...Purchasing has a new program where remote workers can get office furniture at the same price the company does, which is what I used.  You can find the policy and request form in Concierge';
remoteResponse.FeedItemId = remoteQuestion.Id;
remoteResponse.CreatedById = Jesse.Id;
remoteResponse.CreatedDate = system.now().addMinutes(-25);
remoteResponse.RelatedRecordId = desk.LatestPublishedVersionId;
insert remoteResponse;


// that poll!
ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
input.subjectId = salesGroup.Id;

ConnectApi.FeedElementCapabilitiesInput feedElementCapabilitiesInput = new ConnectApi.FeedElementCapabilitiesInput();
ConnectApi.PollCapabilityInput pollCapabilityInput = new ConnectApi.PollCapabilityInput();
pollCapabilityInput.choices = new list<string>();
pollCapabilityInput.choices.add('Demonstration Video');
pollCapabilityInput.choices.add('Installation Guide');
pollCapabilityInput.choices.add('Customer References');
feedElementCapabilitiesInput.poll = pollCapabilityInput;

ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();

messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
textSegmentInput.text = 'What collateral do you need most?  We\'ll create it next';
messageBodyInput.messageSegments.add(textSegmentInput);

input.body = messageBodyInput;
input.capabilities = feedElementCapabilitiesInput;

ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(null,input);

// adding a file to a group
ContentDocumentLink cdl = new ContentDocumentLink();
cdl.ContentDocumentId = [SELECT Id, Title FROM ContentDocument WHERE Title = 'flowchart'].Id;
cdl.LinkedEntityId = salesGroup.Id;
cdl.shareType = 'V';
insert cdl;




