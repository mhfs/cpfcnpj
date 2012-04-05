helpers do
  def javascript_include_tag(*scripts)
    tags = []
    scripts.each do |script|
      script_path = "/javascripts/#{script}"
      tags << content_tag(:script, '', :src => script_path, :type => "text/javascript")
    end
    tags.join("\n")
  end

  def image_tag(file, options = {})
    content_tag(:img, "", options.merge(:src => "/images/#{file}"))
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

  def clippy(element_id, bgcolor='#FFFFFF')
    html = <<-EOF
    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
                  width="110"
                  height="14"
                  class="clippy"
                  id="clippy" >
          <param name="movie" value="/flash/clippy.swf?v5"/>
          <param name="allowScriptAccess" value="always" />
          <param name="quality" value="high" />
          <param name="scale" value="noscale" />
          <param NAME="FlashVars" value="id=#{element_id}&amp;copied=&amp;copyto=">
          <param name="bgcolor" value="#FFFFFF">
          <param name="wmode" value="opaque">
          <embed src="/flash/clippy.swf?v5"
                 width="14"
                 height="14"
                 name="clippy"
                 quality="high"
                 allowScriptAccess="always"
                 type="application/x-shockwave-flash"
                 pluginspage="http://www.macromedia.com/go/getflashplayer"
                 FlashVars="id=#{element_id}&amp;copied=&amp;copyto="
                 bgcolor="#FFFFFF"
                 wmode="opaque"
          />
    </object>
    EOF
  end
end
