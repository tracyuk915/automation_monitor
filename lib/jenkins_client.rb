require 'jenkins_api_client'
require 'date'

class JenkinsClient

  def initialize
    yml = YAML.load(ERB.new(File.read('config/jenkins.yml')).result)[Rails.env]
    @client = JenkinsApi::Client.new(:server_url => yml['server_url'],
                                     :username => yml['username'], :password => yml['password'],
                                     :ssl => yml['ssl'],
                                     :proxy_ip => yml['proxy_ip'], :proxy_port => yml['proxy_port'])
  end

  def last_x_builds(job_name, n=1)
    @client.job.get_builds(job_name)[0..n-1]
  end

  def avg_build_duration(job_name)
    durations = []
    @client.job.get_x_builds(job_name, 10).each do |build|
      hash = @client.job.get_build_details(job_name, build["number"])
      durations << hash["duration"]/1000 if hash['building'] == false
    end
    durations.inject{|sum,x| sum + x } / durations.count
  end

  def build_details(job_name, build_number)
    hash = @client.job.get_build_details(job_name, build_number)

    details = {
      build_str: hash["id"],
      full_name: hash["fullDisplayName"],
      number: hash["number"],
      start_time: Time.at(hash["timestamp"]/1000).utc,
      elapsed_time: Time.now - Time.at(hash["timestamp"]/1000),
      duration: hash["duration"]/1000,
      building: hash["building"]
    }

    details[:result] = hash["building"] ? "RUNNING" : hash["result"]

    gr_count = cases_gr_count(job_name, build_number)
    details[:success_cases_count] = gr_count[0] - gr_count[1]
    details[:failed_cases_count] = gr_count[1]

    details
  end

  def cases_gr_count(job_name, build_number, start = 10000)
    return [0, 0] if start < 0

    output = @client.job.get_console_output(job_name, build_number, start)['output']

    match = /(\d+) examples, (\d+) failures/.match(output)
    if match.nil?
      cases_gr_count(job_name, build_number, start - 1000)
    else
      match[1,2].map {|x| x.to_i}
    end
  end

  private

  def seconds_in_hms(seconds)
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

  def find_latest_pattern(pattern)
    "*****RUNTIME STATUS******:  5/2"
  end
end

