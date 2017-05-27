require_relative '../provider.rb'

module RedguideGit
  class GithubApi < GitProvider
    def initialize(username, password)
      @client = Octokit::Client.new :login => username, :password => password
    end

    # Repository info methods
    def repository_url
      @client.rels[:repos].get.data.each do |repo|
        return repo[:html_url] if repo[:name] == @@repository
      end
    end

    def repository_list
      @client.rels[:repos].get.data
    end

    def branches
      @client.branches(@@repository)
    end

    # Pull request methods
    def pull_requests
      @client.pull_requests(@@repository, state: 'open')
    end

    def create_pull_request
      @client.create_pull_request(@@repository, 'master', @@branch, 'Test')
    end

    def merge_pull_request
      @client.merge_pull_request(@@repository, @@pull_request_number)
    end

    def pull_request_reviews
      @client.pull_request_reviews(@@repository, @@pull_request_number)
    end

    def pull_request_state
      @client.pull_request_reviews(@@repository, @@pull_request_number).first[:state]
    end

    def pull_request_body
      @client.pull_request_reviews(@@repository, @@pull_request_number).first[:body]
    end
  end
end
