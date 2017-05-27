require 'octokit'
# require 'bitbucket_rest_api'
require 'rest-client'
require 'json'

require_relative 'github/github_api.rb'
require_relative 'bitbucket/bitbucket_api.rb'
require_relative 'provider.rb'

module RedguideGit
  class GitApi
    def initialize(provider, username, password, project=nil, repository=nil)
      case provider
      when :github
        @provider = GithubApi.new(username, password)
      when :bitbucket
        @provider = BitbucketApi.new(username, password, project, repository)
      else
        raise 'Unknown provider'
      end
    end

    def user
      @provider.user
    end

    def repository_url
      @provider.repository_url
    end

    def repository_list
      @provider.repository_list
    end

    def pull_request_url
      @provider.pull_request_uri
    end

    def merge_pull_request
      @provider.merge_pull_request
    end

    def pull_request_reviews
      @provider.pull_request_reviews
    end

    def pull_requests
      @provider.pull_requests
    end

    def pull_request_state
      @provider.pull_request_state
    end

    def pull_request_body
      @provider.pull_request_body
    end

    def branches
      @provider.branches
    end

    def create_pull_request
      @provider.create_pull_request
    end

    private
  end
end
