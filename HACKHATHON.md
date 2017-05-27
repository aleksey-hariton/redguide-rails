# Tasks

## RedGudie web

### Configs
- [ ] Projects configs
- [ ] Stage configs
- [ ] Configs editor (YAML/JSON/etc.)
- [ ] "redguide configs get/list" 

### Git 

- [ ] Git support
  - [ ] Stash, bitbucket private
  - [ ] BitBucket
  - [ ] GitHub

### Pipeline

- [ ] Create Pipeline cookbook build script
  - [ ] Move "redguide test" to pipeline
- [ ] Create repo for Pipeline scripts
- [ ] Move BXW script "rake wf:jenkins:grey2" to Pipeline script

### UI

- [ ] Project type - Chef/SaltStack/Ansible/Puppet
- [ ] Nested main menu
- [ ] Cookbooks list view
- [ ] Changesets list view

### Cookbooks build

- [ ] Publish URL/description
- [ ] Step URL, reports
- [ ] Steps load from Pipeline API


### Stages

- [ ] Build job config (project, changeset)
- [ ] Steps icons
- [ ] Steps load from Pipeline API
- [ ] Stage step URL, reports
  - [ ] "redguide stage step report, URL|id" 
- [ ] Stage environment, nodes status in stage during build

### Misc

- [ ] Add to "rake db:seed" DEMO project

## Reporting/Handler

- [ ] Handler, cookbooks version in StackTrace

- [ ] Overall timeline graph 
   - https://s-media-cache-ak0.pinimg.com/originals/8b/e2/5d/8be25df115b72a5d58c46b995b736b89.png
   - https://docs.chef.io/_images/visibility_compliance_overview.png
- [ ] Per node status
- [ ] Ansible handler
- [ ] SaltStack handler
- [ ] Puppet handler