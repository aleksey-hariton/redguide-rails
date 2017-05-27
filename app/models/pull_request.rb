require 'rest-client'
require 'json'
# require "#{Rails.root}/lib/git_api/lib/git_api.rb"

class PullRequest < ApplicationRecord
  belongs_to :cookbook_build
	include RedguideGit
  def check
    self.status = Redguide::API::STATUS_IN_PROGRESS
    save

    project = cookbook_build.changeset.project
    branch = cookbook_build.remote_branch

    git_api = GitApi.new(:bitbucket, project.vcs_server_user,
      project.vcs_server_user_password, project.vcs_server_project, cookbook_build.cookbook.name)

    GitProvider.new(cookbook_build.cookbook.name, branch, project.vcs_server_project)

    pr = git_api.pull_requests.select{|_pr| _pr['fromRef']['displayId'] == branch }.first
    unless pr
      git_api.create_pull_request
    end

    self.url = pr['links']['self'].first['href']
    self.short = "##{pr['id']}"

    approve_count = pr['reviewers'].select{|p| p['approved']}.size

    if git_api.pull_request_state
      self.message = "Approves: #{git_api.pull_request_state.size}"
      self.status = Redguide::API::STATUS_OK
    else
      self.message = 'Not approved'
      self.status = Redguide::API::STATUS_UNKNOWN
    end

    if pr['properties']['mergeResult']['outcome'] == 'CONFLICTED'
      self.message = 'Merge conflict'
      self.status = Redguide::API::STATUS_NOK
    end

    save

  rescue RestClient::Conflict => e
    self.status = Redguide::API::STATUS_UNKNOWN
    self.message = 'No diff with master'
    self.short = 'Up-to-date'
    self.url = ''
    # self.message = e.message + "\n\n" + e.backtrace.join("\n")
    save
  rescue Exception => e
    self.message = e.message + "\n\n" + e.backtrace.join("\n")
    self.status = Redguide::API::STATUS_NOK
    save
  end

end
