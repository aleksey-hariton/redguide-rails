require_relative '../provider.rb'

module RedguideGit
  class BitbucketApi < GitProvider
    def initialize(username, password, project, repository)
      uri = URI.parse('https://bitbucket.booxdev.com')
      uri.user = username
      uri.password = CGI.escape password
      url = "#{uri.to_s}/rest/api/1.0/projects/#{project}/repos/#{repository}"

      @client = RestClient::Resource.new(url)
    end

    def pull_requests
      JSON.parse(@client['pull-requests'].get)['values']
    end

    def branches
      JSON.parse(@client['branches'].get)
    end

    def create_pull_request
      req = {
        title: 'Test',
        description: 'Test',
        fromRef: {
          id: "refs/heads/#{@@branch}",
        },
        toRef: {
          id: 'refs/heads/master',
        },
      }
      pr = JSON.parse(@client['pull-requests'].post(req.to_json, content_type: 'application/json'))
    end

    def pull_request_state
      approvers = []
      JSON.parse(@client['pull-requests'].get)['values'].first['reviewers'].each do |reviewer|
        approvers << reviewer if reviewer['status'] == 'APPROVED'
      end
      approvers
    end
  end
end
