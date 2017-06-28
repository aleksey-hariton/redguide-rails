require 'redguide/api'
require 'fileutils'

class BuildJob < ApplicationRecord

  include JenkinsApi::UriHelper

  def build(job, params)
    jenkins = JenkinsApi::Client.new(
        server_url: params[:jenkins][:host],
        username:   params[:jenkins][:user],
        password:   params[:jenkins][:password]
    )
    log_file = params[:log_file]
    File.delete(log_file) if log_file && File.exists?(log_file)
    self.url = ''
    self.status = Redguide::API::STATUS_SCHEDULED
    self.started_at = DateTime.now
    save

    build_id = jenkins.job.build(job, params[:job_params], {'build_start_timeout' => 60})
    build = jenkins.job.get_build_details(job, build_id)
    self.status = Redguide::API::STATUS_IN_PROGRESS
    self.url = build['url']
    self.stages = get_stages(jenkins, job, build_id)
    save

    # Need this to save console log on first check if job already finished
    build['building'] = true
    log_offset = 0

    while build['building']
      build = jenkins.job.get_build_details(job, build_id)
      if log_file
        create_log_dir(log_file)
        console_out = jenkins.job.get_console_output(job, build_id, log_offset, 'html')
        log_offset = console_out['size']
        console_out = console_out['output'].force_encoding('UTF-8')
        open(log_file, 'a') do |f|
          f << console_out
        end
      end

      if build['duration'] > 0
        self.duration = build['duration'] / 1000
      end

      self.stages = get_stages(jenkins, job, build_id)
      save

      sleep 1
    end

    case build['result']
      when 'SUCCESS'
        self.status = Redguide::API::STATUS_OK
      when 'FAILURE'
          self.status = Redguide::API::STATUS_NOK
      when 'CANCELED'
          self.status = Redguide::API::STATUS_CANCELLED
      else
        self.status = Redguide::API::STATUS_UNKNOWN
    end

    save
    #
    # {
    #     "actions" => [
    #         {"causes" => [
    #             {"shortDescription" => "commit notification 1f4a030b45a920ea4280c579abe9c86f0c29a7a5"}
    #         ]},
    #         {},
    #         {"parameters" => []},
    #         {},
    #         {
    #             "buildsByBranchName" => {
    #                 "origin/master" => {
    #                     "buildNumber" => 5,
    #                     "buildResult" => nil,
    #                     "marked" => {
    #                         "SHA1" => "1f4a030b45a920ea4280c579abe9c86f0c29a7a5",
    #                         "branch" => [
    #                             {
    #                                 "SHA1" => "1f4a030b45a920ea4280c579abe9c86f0c29a7a5",
    #                                 "name" => "origin/master"
    #                             }
    #                         ]
    #                     }, "revision" => {
    #                         "SHA1" => "1f4a030b45a920ea4280c579abe9c86f0c29a7a5",
    #                         "branch" => [
    #                             {
    #                                 "SHA1" => "1f4a030b45a920ea4280c579abe9c86f0c29a7a5",
    #                                 "name" => "origin/master"}
    #                         ]
    #                     }
    #                 }
    #             }, "lastBuiltRevision" => {
    #                   "SHA1" => "1f4a030b45a920ea4280c579abe9c86f0c29a7a5",
    #                   "branch" => [
    #                       {
    #                           "SHA1" => "1f4a030b45a920ea4280c579abe9c86f0c29a7a5",
    #                           "name" => "origin/master"
    #                       }
    #                   ]
    #             },
    #             "remoteUrls" => ["ssh://git@GITSERVER:PORT/chef/mcs.git"],
    #             "scmName" => ""
    #         }, {}, {}, {}
    #     ],
    #     "artifacts" => [],
    #     "building" => false,
    #     "description" => nil,
    #     "displayName" => "#5",
    #     "duration" => 21627,
    #     "estimatedDuration" => 22147,
    #     "executor" => nil,
    #     "fullDisplayName" => "mcs #5",
    #     "id" => "5",
    #     "keepLog" => false,
    #     "number" => 5,
    #     "queueId" => 350099,
    #     "result" => "SUCCESS",
    #     "timestamp" => 1473954199921,
    #     "url" => "https://JENKINS.SERVER/job/mcs/5/",
    #     "builtOn" => "chef-deploy-docker",
    #     "changeSet" => {"items" => [], "kind" => "git"}, "culprits" => []
    # }
  rescue Exception => e
    self.status = Redguide::API::STATUS_NOK
    if log_file
      create_log_dir(log_file)
      ::File.write(log_file, "Message:\n\n#{e}\n\nBacktrace:\n\n#{e.backtrace.join("\n")}")
    end
    save
  end

  def console_url
    File.join(url, 'console')
  end

  def build_number
    File.basename(url)
  end

  def build_steps
    JSON.parse(stages)
  rescue
    []
  end

  private

  def get_stages(jenkins, job, build_id)
    stages = []
    req = jenkins.api_get_request("/job/#{path_encode job }/#{build_id}/wfapi/describe")['stages']
    req.each do |stage|
      stages << {
        :id => stage['id'],
        :name => stage['name'],
        :status => stage['status'],
        :durationMillis => stage['durationMillis']
      }
    end
    stages.to_json
  end

  def create_log_dir(log_file)
    log_dir = File.dirname(log_file)
    FileUtils.mkdir_p(log_dir) unless File.exists?(log_dir)
  end
end
