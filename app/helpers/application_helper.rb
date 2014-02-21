module ApplicationHelper
  def markdown(text)
    markdown_render = Redcarpet::Render::HTML.new(hard_wrap: true, no_styles: true)
    markdown = Redcarpet::Markdown.new(markdown_render, autolink: true, no_intro_emphasis: true) 
    markdown.render(text).html_safe
  end

  def sortable(column, title = nil)
    title ||= column
    sort_fa_icon = column == sort_column ? fa_icon("sort-#{sort_direction}") : fa_icon("sort")
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to "#{title} #{sort_fa_icon}".html_safe, params.merge(sort: column, direction: direction)
  end
end
