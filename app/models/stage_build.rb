class StageBuild < ApplicationRecord
  has_one :stage
  has_one :changeset
  has_one :build_job

  def build
    job = build_job
    unless job
      job = BuildJob.new
      job.status = Redguide::API::STATUS_SCHEDULED
      job.save
      self.build_job_id = job.id
      save
    end


    job.status = Redguide::API::STATUS_SCHEDULED
    job.save
    save

    project = changeset.project
    options = {}
    options[:job_params] = {
      RG_PROJECT: project.key,
      RG_CHANGESET: changeset.key,
    }
    options[:jenkins] = {
      host: project.jenkins_host,
      user: project.jenkins_user,
      password: project.jenkins_password
    }
    options[:log_file] = log_file

    File.delete(log_file) if File.exists? log_file

    job.delay.build(
      'druidgce',
      options
    )
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

  private

  def log_file
    File.join(ENV['JOB_LOG_PATH'], changeset.project.key, changeset.key, 'union_log.log.html')
  end
end
