CollaborationGroup salesGroup = [select id from CollaborationGroup where name = 'Sales Support'];
CollaborationGroup remoteGroup = [select id from CollaborationGroup where name = 'Remote Workers'];

ContentDocument desk = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument WHERE Title = 'desk'];

// ask a question in the remote workers group?
feeditem remoteQuestion = new feeditem();
remoteQuestion.body = 'I\'m really struggling with posture since coming back to work.  I miss my sit/stand desk back at HQ.  What do you use in your home ofremoteQuestionce?';
remoteQuestion.parentId = remoteGroup.Id;
remoteQuestion.createdDate = system.now().addHours(-1);
insert remoteQuestion;

FeedComment remoteResponse = new FeedComment();
remoteResponse.CommentBody = 'I have on of these...Purchasing has a new program where remote workers can get office furniture at the same price the company does, which is what I used.  You can find the policy and request form in Concierge';
remoteResponse.FeedItemId = remoteQuestion.Id;
remoteResponse.CreatedBy = [select Id, Name from User where Name != 'Jenny Nunez' limit 1];
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



