module BoxoverHelper

  #
  # specify here defaults that override the library defaults
  #
  Defaults = 
  {
    :cssheader => "boxover-header",
    :cssbody   => "boxover-body",
    :fadespeed => "0.1"
  }

  #
  # an helper to simplify the use of boxover in title attribute 
  # 
  # usage: 
  #
  #   :title => boxover("This is an example of body-only tooltip")
  #   :title => boxover("This is an example of body and header tooltip", "Tooltip:")
  #   :title => boxover("This is an example of body-only with options", :fade => true)
  #   :title => boxover("This is an example of body and header with options", "Tooltip:", :fade => true)
  #
  def boxover(body, header_or_options = '', options = {})
    
    if header_or_options.kind_of?(Hash)
      # boxover(body, header, options = {})
      options = header_or_options
      header = ''
    else
      # boxover(body, options = {})
      header = header_or_options
    end
    
    # from http://boxover.swazz.org/#section16
    valid_options = [
    # Specifies the header text of the tooltip
    # - any character (default:blank) -
    :header,
    # Specifies the body text of the tooltip
    # - any character (default:blank) -
    :body,
    # Forces the X-coordinate of the tooltip to stay fixed 
    # (offset is relative to the annotated HTML element)
    # - any integer (default:N/A) -
    :fixedrelx,
    # Forces the Y-coordinate of the tooltip to stay fixed
    # (offset is relative to the annotated HTML element)
    # - any integer (default:N/A) -
    :fixedrely,
    # Forces the X-coordinate of the tooltip to stay fixed 
    # (X is an offset relative to the body of the HTML document)
    :fixedabsx,       
    # Forces the Y-coordinate of the tooltip to stay fixed 
    # (Y is an offset relative to the body of the HTML document)
    # - any integer (default:N/A) -
    :fixedabsy,       
    # Make tooltip stick to side of the window 
    # if user moves close to the side of the screen.
    # - on / off (default: on) - 
    :windowlock,      
    # Specifies CSS class for styles to be used on tooltip body.
    # - any defined style class (default:built in styles) -
    :cssbody,         
    # Specifies CSS class for styles to be used on tooltip header.
    # - any defined style class (default:built in styles) -
    :cssheader,       
    # Horizontal offset, in pixels, of the tooltip relative to the mouse cursor.
    # - any integer (default:10) -
    :offsetx,         
    # Vertical offset, in pixels, of the tooltip relative to the mouse cursor.
    # - any integer (default:10) -
    :offsety,         
    # Specifies whether to halt the tooltip when the user 
    # double clicks on the HTML element with the tooltip.
    # - on / off (default:on) - 
    :doubleclickstop, 
    # Specifies whether to halt the tooltip when the user 
    # single clicks on the HTML element with the tooltip. 
    # If both singleclickstop and doubleclickstop are set to "on", 
    # singleslclickstop takes preference.
    # - on / off (default:off) - 
    :singleclickstop, 
    # Specifies whether the user must first click the element before a tooltip appears. 
    # Intended for use on links so that information appears while the link is followed.
    # - on / off (default:off) -              
    :requireclick,    
    # Specifies whether to hide all SELECT boxes on page when popup is activated.
    # - on / off (default:off) -
    :hideselects,     
    # Specifies whether to fade tooltip into visibility.
    # - on / off (default:off) -
    :fade,
    # Specifies how fast to fade in tooltip.
    # - number between 0 and 1 (default:0.04) - 
    :fadespeed,
    # Specifies delay in milliseconds before tooltip displays.
    # - any integer (default:0) -
    :delay ]
    
    options.assert_valid_keys(*valid_options)
    options.reverse_merge!(:header => header, :body => body)
    options.reverse_merge!(Defaults)
    
    # allow to specify boolean options using rails style (=> true / => false)
    options.each_pair do |k,v| 
      options[k]="on"  if v == true
      options[k]="off" if v == false or v.nil?
    end
    
    # [ ] in a string would cause boxover to fail
    # TODO: can they be escaped or otherwise encoded?
    if options.values.any? {|x| x=~/[\[\]]/}
      raise ArgumentError, "boxover: [ and ] not allowed in values" 
    end
    
    # return the options transformed in a boxover format string
    return options.map {|k, v| "#{k}=[#{v}]"}.join(' ')
    
  end

end
