module ErrorReportsHelper

  def error_report_icon(error_report)
    if error_report && error_report.status && error_report.status != 0
      status = error_report.status
    else
      status = Node::STATUS_UNKNOWN
      url = '#'
    end

    case status
      when Node::STATUS_NOK
        fa_icon = 'times'
        description = 'Failed'
        css_class = 'bg-red'
      when Node::STATUS_OK
        fa_icon = 'check'
        description = 'Passed'
        css_class = 'bg-green'
      else
        fa_icon = 'question'
        description = 'Unknown'
        css_class = 'bg-yellow'
    end

     %Q(<i class="fa fa-#{fa_icon} #{css_class}" > &nbsp; </i>).html_safe
  end
end
