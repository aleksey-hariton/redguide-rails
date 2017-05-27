module RedguideGit
  class GitProvider
    def initialize(repository, branch, project=nil, pull_request_number=nil)
      @@repository = repository
      @@branch = branch
      @@pull_request_number = pull_request_number
      @@project = project
      @@repository = repository
      @@pull_request_number = pull_request_number
    end

    def user
      raise 'Asbtract method call'
    end

    def repository_url(repository)
      raise 'Asbtract method call'
    end

    def repository_list
      raise 'Asbtract method call'
    end

    def pull_request_url
      raise 'Asbtract method call'
    end

    def merge_pull_request
      raise 'Asbtract method call'
    end

    def pull_request_reviews
      raise 'Asbtract method call'
    end

    def pull_requests
      raise 'Asbtract method call'
    end

    def pull_request_state
      raise 'Asbtract method call'
    end

    def pull_request_body
      raise 'Asbtract method call'
    end

    def branches
      raise 'Asbtract method call'
    end

    def create_pull_request
      raise 'Asbtract method call'
    end
  end
end
