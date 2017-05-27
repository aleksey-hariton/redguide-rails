# Tasks

## RedGudie web

### Configs
- [x] Projects configs
- [ ] Stage configs
- [x] Configs editor (YAML/JSON/etc.)
- [x] "redguide configs get/list" 

### Git 

- [ ] Git support
  - [x] Stash, bitbucket private
  - [ ] BitBucket
  - [x] GitHub

### Pipeline

- [x] Create Pipeline cookbook build script
- [ ] Move "redguide test" to pipeline
- [ ] Create repo for Pipeline scripts
- [ ] Move BXW script "rake wf:jenkins:grey2" to Pipeline script

### UI

- [x] Project type - Chef/SaltStack/Ansible/Puppet
- [x] Nested main menu
- [x] Cookbooks list view
- [x] Changesets list view

### Cookbooks build

- [ ] Publish URL/description
- [ ] Step URL, reports
- [x] Steps load from Pipeline API


### Stages

- [ ] Build job config (project, changeset)
- [x] Steps icons
- [x] Steps load from Pipeline API
- [ ] Stage step URL, reports
  - [ ] "redguide stage step report, URL|id" 
- [ ] Stage environment, nodes status in stage during build

### Misc

- [ ] Add to "rake db:seed" DEMO project

## Reporting/Handler

- [ ] Handler, cookbooks version in StackTrace

- [x] Overall timeline graph 
   - https://s-media-cache-ak0.pinimg.com/originals/8b/e2/5d/8be25df115b72a5d58c46b995b736b89.png
   - https://docs.chef.io/_images/visibility_compliance_overview.png
- [x] Per node status
- [ ] Ansible handler
- [ ] SaltStack handler
- [ ] Puppet handler