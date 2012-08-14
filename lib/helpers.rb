helpers do
  def javascript_include_tag(*scripts)
    tags = []
    scripts.each do |script|
      script_path = "/javascripts/#{script}"
      tags << content_tag(:script, '', :src => script_path, :type => "text/javascript")
    end
    tags.join("\n")
  end

  def stylesheet_link_tag(*sheets)
    tags = []
    sheets.each do |sheet|
      sheet_path = "/stylesheets/#{sheet}"
      tags << content_tag(:link, '', :href => sheet_path, :type => "text/css", :rel => "stylesheet", :media => "screen, projection")
    end
    tags.join("\n")
  end

  def link_to(text, path, options = {})
    options.merge!({:href => path})
    content_tag(:a, text, options)
  end

  def content_tag(name, content, options)
    tag_options = tag_options(options) if options
    "<#{name}#{tag_options}>#{content}</#{name}>"
  end

  def tag_options(options)
    attrs = options.map { |key, value| %(#{key}="#{value}") }
    " #{attrs.sort * ' '}"
  end

  def partial(template, *args)
    template_array = template.to_s.split('/')
    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
    options = args.last.is_a?(Hash) ? args.pop : {}
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << haml(:"#{template}", options.merge(:layout =>
        false, :locals => {template_array[-1].to_sym => member}))
      end.join("\n")
    else
      haml(:"#{template}", options)
    end
  end

  def cycle
    %w{even odd}[@_cycle = ((@_cycle || -1) + 1) % 2]
  end
end
