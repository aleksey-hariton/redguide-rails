module NodesHelper
  def node_status_widget(node)
    if node && node.status && node.status != 0 && node.error_reports.last != nil
      status = node.status
      url = organization_environment_node_error_report_url(@organization, @environment, node, node.error_reports.last)
    else
      status = Node::STATUS_UNKNOWN
      url = '#'
    end

    case status
      when Node::STATUS_NOK
        fa_icon = 'times'
        description = 'Failed'
        css_class = 'label-danger'
      when Node::STATUS_OK
        fa_icon = 'check'
        description = 'Passed'
        css_class = 'label-success'
      else
        fa_icon = 'question'
        description = 'Unknown'
        css_class = 'label-warning'
    end

    link_to %Q(<span class="label #{css_class}" style="font-size: 11px; margin-right: 5px">#{icon(fa_icon, description)}</span>).html_safe, url
  end

end
