require 'rest-client'
require 'json'

class PullRequest < ApplicationRecord
  belongs_to :cookbook_build

  def check
    self.status = Redguide::API::STATUS_IN_PROGRESS
    save
    project = cookbook_build.changeset.project
    uri = URI.parse(project.vcs_server)
    uri.user = project.vcs_server_user
    uri.password = project.vcs_server_user_password
    url = "#{uri.to_s}/rest/api/1.0/projects/#{project.vcs_server_project}/repos/#{cookbook_build.cookbook.name}"
    client = RestClient::Resource.new(url)
    prs = JSON.parse(client['pull-requests'].get)['values']

    branch = cookbook_build.remote_branch

    pr = prs.select{|_pr| _pr['fromRef']['displayId'] == branch }.first
    unless pr
      req = {
          title: "#{cookbook_build.changeset.key} - #{cookbook_build.changeset.description}",
          description: cookbook_build.changeset.description,
          fromRef: {
              id: "refs/heads/#{branch}",
          },
          toRef: {
              id: 'refs/heads/master',
          },
      }
      self.message = req.to_json
      pr = JSON.parse(client['pull-requests'].post(req.to_json, content_type: 'application/json'))
    end

    self.url = pr['links']['self'].first['href']
    self.short = "##{pr['id']}"

    approve_count = pr['reviewers'].select{|p| p['approved']}.size

    if approve_count > 0
      self.message = "Approves: #{approve_count}"
      self.status = Redguide::API::STATUS_OK
    else
      self.message = 'Not approved'
      self.status = Redguide::API::STATUS_UNKNOWN
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
