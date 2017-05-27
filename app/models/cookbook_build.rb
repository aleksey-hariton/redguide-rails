class CookbookBuild < ApplicationRecord
  belongs_to :changeset
  belongs_to :cookbook
  has_one :build_job
  has_one :pull_request

  validates :cookbook_id,
            uniqueness: {
                scope: :changeset_id,
                message: 'already added'
            }

  def build
    return unless can_rebuild?

    job = build_job
    unless job
      job = BuildJob.new
      job.status = Redguide::API::STATUS_SCHEDULED
      job.save
      self.build_job_id = job.id
      save
    end

    reset
    job.status = Redguide::API::STATUS_SCHEDULED
    job.save
    save

    project = changeset.project
    options = {}
    options[:job_params] = {
        RG_PROJECT: project.key,
        RG_CHANGESET: changeset.key,
        COMMIT: self.remote_branch,
        COOKBOOK: cookbook.name,
        VCS_URL: cookbook.vcs_url
    }
    options[:jenkins] = {
        host: project.jenkins_host,
        user: project.jenkins_user,
        password: project.jenkins_password
    }
    options[:log_file] = log_file

    File.delete(log_file) if File.exists? log_file

    job.delay.build(
        project.cookbook_build_job,
        options
    )
  end

  def progress
    progress = 95
    if build_job && cookbook.avg_build_time > 0
      progress = ((elapsed / cookbook.avg_build_time) * 100).to_i
    end

    if build_job && build_job.duration > 0
      cookbook.avg_build_time = (cookbook.avg_build_time + build_job.duration)/2
      cookbook.save
    end

    progress = 99 if progress > 100
    progress
  end

  def elapsed
    DateTime.now.to_time - build_job.started_at.to_time
  end

  def duration
    build_job ? build_job.duration : 0
  end

  def job_url
    build_job ? build_job.url : ''
  end

  def started_at
    build_job ? build_job.started_at : nil
  end

  def status
    build_job ? build_job.status : Redguide::API::STATUS_NOT_STARTED
  end

  def build_job
    @build_job ||= BuildJob.find_by(id: build_job_id)
    if @build_job && [
        Redguide::API::STATUS_SKIPPED,
        Redguide::API::STATUS_NOK,
        Redguide::API::STATUS_UNKNOWN
    ].include?(@build_job.status)
      self.foodcritic_status = Redguide::API::STATUS_UNKNOWN if self.foodcritic_status == Redguide::API::STATUS_IN_PROGRESS
      self.cookstyle_status = Redguide::API::STATUS_UNKNOWN if self.cookstyle_status == Redguide::API::STATUS_IN_PROGRESS
      self.rspec_status = Redguide::API::STATUS_UNKNOWN if self.rspec_status == Redguide::API::STATUS_IN_PROGRESS
      self.kitchen_status = Redguide::API::STATUS_UNKNOWN if self.kitchen_status == Redguide::API::STATUS_IN_PROGRESS
    end

    @build_job
  end

  def pr
    if self.pull_request.nil?
      self.pull_request = PullRequest.new(cookbook_build_id: self.id)
      self.pull_request.status = Redguide::API::STATUS_UNKNOWN
      self.pull_request.short = 'No-PR'
      self.pull_request.save!
    end
    self.pull_request
  end

  def check_pr
    pr.status = Redguide::API::STATUS_SCHEDULED
    pr.save
    pr.delay.check
  end
  
  def console_out
    if File.exists? log_file
      File.read(log_file)
    else
      'No logs'
    end
  end

  def can_rebuild?
    statuses = [
        Redguide::API::STATUS_IN_PROGRESS,
        Redguide::API::STATUS_SCHEDULED,
    ]
    # Dont restart if no commit sha or scheduled/in progress
    !commit_sha.empty? && !statuses.include?(status)
  end

  def reset
    self.foodcritic_status = Redguide::API::STATUS_UNKNOWN
    self.cookstyle_status = Redguide::API::STATUS_UNKNOWN
    self.rspec_status = Redguide::API::STATUS_UNKNOWN
    self.kitchen_status = Redguide::API::STATUS_UNKNOWN
    save
  end

  private

  def log_file
    File.join(ENV['JOB_LOG_PATH'], changeset.project.key, changeset.key, 'cookbooks', cookbook.name + '.log.html')
  end
end
