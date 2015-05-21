module NavbarHelper
  class NavbarBuilder
    attr_reader :temp

    def initialize(template)
      @temp = template
    end

    def brand_tag(content, url, options = {})
      temp.link_to(content, url, {class: 'navbar-brand'}.merge(options))
    end

    def navbar_tag(options = {}, &block)
      css = "nav navbar-nav #{options.delete(:class)}".strip
      temp.content_tag(:ul, {class: css}.merge(options)) do
        yield self
      end
    end

    def navbar_item_tag(content, url, link_options = {})
      temp.content_tag(:li, navbar_item_attrs(url)) do
        temp.link_to(content,url, link_options)
      end      
    end

    private

    def navbar_item_attrs(url)
      current_page?(url) ? { class: 'active' } : {}
    end

    def current_page?(url)
      %r[\A#{url}] =~ temp.request.path
    end
  end

  def navbar(options = {}, &block)
    builder = NavbarBuilder.new(self)
    content_tag(:div, {class: 'container'}.merge(options)) do
      yield builder
    end
  end
end