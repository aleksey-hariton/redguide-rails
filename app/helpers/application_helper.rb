require 'redguide/api'

module ApplicationHelper
  def user_avatar(size, user=current_user)
    user.gravatar_url(:rating => 'R', :size => size, :secure => true)
  end


  def icon(icon, text)
    text = " #{text}" unless text.nil? || text.empty?
    %Q(<i class="fa fa-#{icon}"></i>#{text})
  end

  def status_label(status, with_text=true, label=true)
    case status
      when Redguide::API::STATUS_UNKNOWN
        fa_icon = 'question'
        description = 'Unknown'
        css_class = 'label-warning'
      when Redguide::API::STATUS_CANCELLED
        fa_icon = 'times'
        description = 'Cancelled'
        css_class = 'label-danger'
      when Redguide::API::STATUS_NOK
        fa_icon = 'times'
        description = 'Failed'
        css_class = 'label-danger'
      when Redguide::API::STATUS_OK
        fa_icon = 'check'
        description = 'Success'
        css_class = 'label-success'
      when Redguide::API::STATUS_SKIPPED
        fa_icon = ''
        description = 'Skipped'
        css_class = 'label-default'
      when Redguide::API::STATUS_SCHEDULED
        fa_icon = 'refresh fa-spin'
        description = 'Scheduled'
        css_class = 'label-primary'
      when Redguide::API::STATUS_IN_PROGRESS
        fa_icon = 'refresh fa-spin'
        description = 'In progress'
        css_class = 'label-primary'
      when Redguide::API::STATUS_NOT_STARTED
        fa_icon = 'minus'
        description = 'Not started'
        css_class = 'label-primary'
      else
        fa_icon = 'question'
        description = 'Unknown'
        css_class = 'label-warning'
    end

    if label
      %Q(<span class="label #{css_class}" title="#{description}" style="font-size: 11px;">#{icon(fa_icon, with_text ? description : '')}</span>).html_safe
    else
      %Q(#{icon(fa_icon, description)}).html_safe
    end
  end
end
