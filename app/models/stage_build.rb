class StageBuild < ApplicationRecord
  belongs_to :stage
  has_one :changeset
  has_one :build_job

  def can_rebuild?
    statuses = [
        Redguide::API::STATUS_IN_PROGRESS,
        Redguide::API::STATUS_SCHEDULED,
    ]
    # Dont restart if scheduled/in progress
    !statuses.include?(status)
  end



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
    job.stages = ''
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
      stage.jenkins_job,
      options
    )
  end

  def console_url
    build_job.console_url
  end

  def build_number
    build_job.build_number
  end

  def steps
    res = []
    stage.steps.each do |stage_step|

      step = {}
      step['icon'] = stage_step.icon
      step['name'] = stage_step.description
      step['status'] = 'NOT STARTED'
      step['color'] = 'info-box bg-gray'
      step_urls = stage_step.urls
      if step_urls
        step_urls = JSON.parse(step_urls)
        step_urls.each_value { |url| url.replace("http://#{url}") unless url.start_with?('http://', 'https://') }
        step['urls'] = step_urls
      end
      step['duration'] = 0
      build_job.build_steps.each do |build_step|
        if stage_step.description == build_step['name']
          step['status'] = build_step['status']
          step['icon'] = 'refresh fa-spin' if build_step['status'] == 'IN_PROGRESS'

          # color
          case build_step['status']
            when 'SUCCESS'
              color = 'info-box bg-green'
            when 'FAILED'
              color = 'info-box bg-red'
            when 'IN_PROGRESS'
              color = 'info-box bg-blue'
          end
          step['color'] = color

          # duration
          step['duration'] = build_step['durationMillis'] / 1000
        end
      end
      res << step
    end
    res
  end

  def started_at
    build_job ? build_job.started_at : nil
  end

  def status
    build_job ? build_job.status : Redguide::API::STATUS_NOT_STARTED
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

  # Method hidden to +private+ section to prevent direct usage!
  def build_job
    @build_job ||= BuildJob.find_by(id: build_job_id)

    unless @build_job
      @build_job = BuildJob.new
      self.build_job_id = @build_job.id
      @build_job.save
    end

    @build_job
  end

  private

  def log_file
    File.join(ENV['JOB_LOG_PATH'], changeset.project.key, changeset.key, 'union_log.log.html')
  end
end
