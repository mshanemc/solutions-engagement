sfdx force:org:create -f config/project-scratch-def.json -d 1 -s
# cadalys concierge
# sfdx force:package:install --package 04t460000027gmI -w 50 -r
# sfdx shane:github:package:install -g mshanemc -r lwc-org-chart
sfdx force:source:push
sfdx force:user:permset:assign -n solutions
sfdx force:apex:execute -f scripts/connectedAppSetup.cls
sfdx force:data:record:update -s User -w "Name='User User'" -v "FirstName='Jenny' LastName='Nunez'"
sfdx force:data:record:update -s User -w "Name='Integration User'" -v "FirstName='William' LastName='Loman'"
sfdx force:data:tree:import -f data/CollaborationGroup.json
sfdx shane:user:photo -g Jenny -l Nunez -f assets/jenny.jpeg
sfdx shane:data:file:upload -f assets/flowchart.pdf
sfdx shane:data:file:upload -f assets/desk.jpg
sfdx force:apex:execute -f scripts/chatterSetup.cls

sfdx force:org:open -p /lightning/setup/ThemingAndBranding/home