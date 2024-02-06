module ApplicationHelper
  require "redcarpet"
  require "rouge"
  require "rouge/plugins/redcarpet"

  class RougeHTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end
  
  def render_markdown_highlighting(file_path)

    render_options = { 
      no_links: false,
      hard_wrap: true,
      link_attributes: { target: '_blank'}
    }
    extensions = {
      disable_indented_code_blocks: true,
      hard_wrap: true,
      autolink: true,
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      strikethrough: true,
      lax_spacing: true,
      space_after_headers: true,
      quote: true,
      footnotes: true,
      highlight: true,
      underline: true
    }

    content = File.read(Rails.root.join("app/views", file_path))
    erb_content = ERB.new(content).result(binding)
  
    renderer = RougeHTML.new(render_options)
  
    markdown = Redcarpet::Markdown.new(renderer, extensions).render(erb_content).html_safe
  end
end
