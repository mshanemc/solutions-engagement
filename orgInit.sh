sfdx force:org:create -f config/project-scratch-def.json -d 1 -s
# cadalys concierge
sfdx force:package:install --package 04t460000027gmI -w 50 -r
sfdx shane:github:package:install -g mshanemc -r lwc-org-chart
sfdx force:source:push
sfdx force:user:permset:assign -n solutions
sfdx force:apex:execute -f scripts/connectedAppSetup.cls
sfdx force:data:tree:import -f data/CollaborationGroup.json
sfdx force:org:open