sfdx shane:org:create -f config/project-scratch-def.json -d 1 -s -n --userprefix electron --userdomain ee.demo
sfdx force:data:bulk:upsert -f data/Knowledge__kav.csv -i id -s Knowledge__kav 

# cadalys concierge
sfdx force:package:install --package 04t460000027gmI -w 50 -r
# TODO: create some past tickets via bulk load

sfdx shane:github:package:install -g mshanemc -r lwc-org-chart
sfdx force:user:permset:assign -n OrgChart
sfdx force:user:create Firstname=Report Lastname=One IsActive=false Title=Designer MobilePhone=8324728021
sfdx force:user:create Firstname=Report Lastname=Two IsActive=false Title=Designer MobilePhone=8324728021
sfdx force:user:create Firstname=Report Lastname=Three IsActive=false Title=Engineer MobilePhone=8324728021
sfdx force:user:create Firstname=Report Lastname=Four IsActive=false Title=Engineer MobilePhone=8324728021
sfdx force:user:create Firstname=Report Lastname=Five IsActive=false Title=Engineer MobilePhone=8324728021
sfdx force:user:create Firstname=Sir Lastname=Boss IsActive=false Title=CEO MobilePhone=8324728021
sfdx force:apex:execute -f scripts/orgChartSetup.cls

sfdx force:source:push
sfdx force:user:permset:assign -n solutions
sfdx force:apex:execute -f scripts/connectedAppSetup.cls
sfdx force:data:record:update -s User -w "Name='User User'" -v "FirstName='Jenny' LastName='Nunez' UserPermissionsKnowledgeUser=true"
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

sfdx force:org:open -p /lightning/setup/ThemingAndBranding/home
sfdx shane:user:password:set -g Jenny -l Nunez -p sfdx1234

# TODO: set the photos properly instead of my evil version
sfdx shane:user:allPhotos