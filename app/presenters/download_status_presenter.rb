class DownloadStatusPresenter < ApplicationPresenter
  def status
    if downloads.any?
      'downloaded'
    elsif queued?
      'queued'
    elsif retrying?
      'retrying'
    elsif downloading?
      'downloading'
    elsif dead?
      'dead'
    else
      'unknown'
    end
  end

  def queued?
    !!index_of_job_in_queue
  end
  def retrying?
    !!retry_job
  end
  def dead?
    !!index_of_job(Sidekiq::DeadSet.new)
  end

  def retry_job
    return @retry_job if defined?(@retry_job)

    retries = Sidekiq::RetrySet.new.to_a
    index = index_of_job(retries)
    @retry_job = index && retries[index]
  end

  def downloading?
    Sidekiq::Workers.new.any? do |_, _, work|
      work.dig('payload', 'args', 0) == object.id
    end
  end

  def index_of_job_in_queue
    @index_of_job_in_queue ||= index_of_job Sidekiq::Queue.new('default')
  end

  def place_in_queue
    return nil unless index_of_job_in_queue

    place = index_of_job_in_queue + 1
    suffix = case place % 10
             when 1 then "st"
             when 2 then "nd"
             when 3 then "rd"
             else "th"
             end
    "#{place}#{suffix} in queue"
  end

  def retry_status
    return nil unless retrying?

    out = "Retrying"

    if retry_job.item['retry_count']
      out += " (#{retry_job.item['retry_count']} / 25)"
    end

    retry_at = Time.zone.at(retry_job.score)
    # binding.pry
    if retry_at.future?
      if retry_at.today?
        ap retry_at
        ap Time.zone
        out += " at " + I18n.l(retry_at, format: :time)
      else
        out += " " + I18n.l(retry_at, format: :short)
      end
    end

    if retry_job.item['error_message']
      out += " (#{retry_job.item['error_message']})"
    end

    ap retry_job.item['retry_count']
    out
  end

  private

  def index_of_job(queue)
    queue.find_index do |job|
      job.args[0] == object.id
    end
  end
end
