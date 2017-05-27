require 'redguide/api'

module ApplicationHelper
  def user_avatar(size, user=current_user)
    user.gravatar_url(:rating => 'R', :size => size, :secure => true)
  end


  def icon(icon, text)
    text = " #{text}" unless text.nil? || text.empty?
    %Q(<i class="fa fa-#{icon}"></i>#{text})
  end

  def status_label(status, with_text=true, label=true, descr='')
    if status.kind_of? String
      if status =='SUCCESS'
        status =  Redguide::API::STATUS_OK
      elsif status =='IN_PROGRESS'
        status = Redguide::API::STATUS_IN_PROGRESS
      else
        status = Redguide::API::STATUS_NOK
      end
    end

    case status
      when Redguide::API::STATUS_UNKNOWN
        fa_icon = 'question'
        description = descr.empty? ? 'Unknown': descr
        css_class = 'label-warning'
      when Redguide::API::STATUS_CANCELLED
        fa_icon = 'times'
        description =  descr.empty? ? 'Cancelled': descr
        css_class = 'label-danger'
      when Redguide::API::STATUS_NOK
        fa_icon = 'times'
        description = descr.empty? ? 'Failed': descr
        css_class = 'label-danger'
      when Redguide::API::STATUS_OK
        fa_icon = 'check'
        description = descr.empty? ? 'Success': descr
        css_class = 'label-success'
      when Redguide::API::STATUS_SKIPPED
        fa_icon = ''
        description = descr.empty? ? 'Skipped': descr
        css_class = 'label-default'
      when Redguide::API::STATUS_SCHEDULED
        fa_icon = 'refresh fa-spin'
        description = descr.empty? ? 'Scheduled': descr
        css_class = 'label-primary'
      when Redguide::API::STATUS_IN_PROGRESS
        fa_icon = 'refresh fa-spin'
        description = descr.empty? ?  'In progress': descr
        css_class = 'label-primary'
      when Redguide::API::STATUS_NOT_STARTED
        fa_icon = 'minus'
        description = descr.empty? ? 'Not started': descr
        css_class = 'label-primary'
      else
        fa_icon = 'question'
        description = descr.empty? ? 'Unknown': descr
        css_class = 'label-warning'
    end

    if label
      %Q(<span class="label #{css_class}" title="#{description}" style="font-size: 11px;">#{icon(fa_icon, with_text ? description : '')}</span>).html_safe
    else
      %Q(#{icon(fa_icon, description)}).html_safe
    end
  end
end
