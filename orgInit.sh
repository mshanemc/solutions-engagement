sfdx shane:org:create -f config/project-scratch-def.json -d 30 -s -n --userprefix electron --userdomain ee.demo
sfdx force:source:deploy -p certs
# community boilerplate to support bot preview
sfdx force:package:install --package 04t6A000003OhCUQA0 -r

sfdx shane:cert:unhardcode -f force-app/main/default/samlssoconfigs/MyIDP.samlssoconfig-meta.xml -l TheCert
sfdx force:data:record:update -s User -w "Name='User User'" -v "FirstName='Jenny' LastName='Nunez' UserPermissionsKnowledgeUser=true"

# concierge
sfdx force:package:install --package 04t46000001zoPFAAY -r --wait 50

# local edits before push, will cause a wait
sfdx force:source:push

sfdx force:source:deploy -p communities

sfdx shane:communities:json:modify -f communities/main/default/experiences/employeebots1/views/home.json -i 69c03077-932a-4c08-b932-46baec5a7c86 -p eswConfigurationJSON -s buttonId -q "select id from liveChatButton" --write --truncate
sfdx shane:communities:json:modify -f communities/main/default/experiences/employeebots1/views/home.json -i 69c03077-932a-4c08-b932-46baec5a7c86 -p eswConfigurationJSON -s deploymentId -q "select id from LiveChatDeployment" --write --truncate
sfdx shane:communities:json:modify -f communities/main/default/experiences/employeebots1/views/home.json -i 69c03077-932a-4c08-b932-46baec5a7c86 -p eswConfigurationJSON -s eswConfigId -q "select id from EmbeddedServiceConfig" --write -t
sfdx shane:communities:json:modify -f communities/main/default/experiences/employeebots1/views/home.json -i 69c03077-932a-4c08-b932-46baec5a7c86 -p eswConfigurationJSON -s orgId --variable OrgId --write --truncate
sfdx shane:communities:json:modify -f communities/main/default/experiences/employeebots1/views/home.json -i 69c03077-932a-4c08-b932-46baec5a7c86 -p eswConfigurationJSON -s baseLiveAgentURL -q "select id, LiveAgentChatUrl from EmbeddedServiceLiveAgent" --write --queryfield LiveAgentChatUrl -t
sfdx shane:communities:json:modify -f communities/main/default/experiences/employeebots1/views/home.json -i 69c03077-932a-4c08-b932-46baec5a7c86 -p eswConfigurationJSON -s baseLiveAgentContentURL -q "select id, LiveAgentContentUrl from EmbeddedServiceLiveAgent" --write --queryfield LiveAgentContentUrl -t
sfdx shane:communities:json:modify -f communities/main/default/experiences/employeebots1/views/home.json -i 69c03077-932a-4c08-b932-46baec5a7c86 -p eswConfigurationJSON -s baseCoreURL --variable InstanceUrl --write
sfdx force:data:record:update -s User -w "Name='Jenny Nunez'" -v "isRemote__c=true Street='123 Main' City=Magnolia State=TX PostalCode=77355"

# push again for communities local edits
sfdx force:source:deploy -p communities

sfdx force:user:permset:assign -n solutions
sfdx force:data:bulk:upsert -f data/Knowledge__kav.csv -i id -s Knowledge__kav

sfdx shane:github:package:install -g mshanemc -r lwc-org-chart
sfdx force:user:permset:assign -n OrgChart
sfdx force:user:create Firstname=Report Lastname=One IsActive=false Title=Designer MobilePhone=8324728021
sfdx force:user:create Firstname=Report Lastname=Two IsActive=false Title=Designer MobilePhone=8324728021
sfdx force:user:create Firstname=Report Lastname=Three IsActive=false Title=Engineer MobilePhone=8324728021
sfdx force:user:create Firstname=Report Lastname=Four IsActive=false Title=Engineer MobilePhone=8324728021
sfdx force:user:create Firstname=Report Lastname=Five IsActive=false Title=Engineer MobilePhone=8324728021
sfdx force:user:create Firstname=Shannon Lastname=Duffy IsActive=false Title=CEO MobilePhone=8324728021
sfdx force:apex:execute -f scripts/orgChartSetup.cls

sfdx force:apex:execute -f scripts/connectedAppSetup.cls
sfdx force:data:record:update -s User -w "Name='Integration User'" -v "FirstName='William' LastName='Loman'"
sfdx force:data:record:update -s User -w "Name='Security User'" -v "FirstName='Jesse' LastName='Sanchez'"
sfdx force:data:tree:import -f data/CollaborationGroup.json
sfdx shane:user:photo -g Jenny -l Nunez -f assets/jenny.jpeg
sfdx shane:data:file:upload -f assets/flowchart.pdf
sfdx shane:data:file:upload -f assets/desk.jpg
sfdx force:apex:execute -f scripts/chatterSetup.cls

sfdx shane:github:package:install -g mshanemc -r employee-safety
sfdx shane:github:package:install -g mshanemc -r electron-theme
sfdx force:user:permset:assign -n Safety
sfdx force:data:bulk:upsert -f data/incident_reports.csv -s Incident_Report__c -i id
sfdx force:data:bulk:upsert -f data/observations.csv -s Observation__c -i id

sfdx force:apex:execute -f scripts/conciergeSetup.cls
sfdx shane:concierge:chat:enable
# sfdx shane:org:reauth -r --json
sfdx shane:theme:activate -n Electron
sfdx force:org:open
sfdx shane:user:password:set -g Jenny -l Nunez -p sfdx1234

# set the photos properly instead of my evil version
sfdx shane:user:photo -g William -l Loman -f assets/loman.jpeg
sfdx shane:user:photo -g Shannon -l Duffy -f assets/shannon.png
sfdx shane:user:photo -g Jesse -l Sanchez -f assets/jesse.jpeg

sfdx shane:user:allPhotos -f assets/userPhotos
sfdx shane:group:photo -f assets/groupPhotos/dog.png -g "Remote Workers"