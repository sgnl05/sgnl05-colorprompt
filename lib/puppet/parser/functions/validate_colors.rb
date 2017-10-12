#
# validate_colors.rb
#

module Puppet::Parser::Functions
  newfunction(:validate_colors, :type => :rvalue, :doc => <<-EOS
  This function validate colors for user console.
  EOS
  ) do |arguments|

    raise(Puppet::ParseError, "validate_colors(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)") if arguments.size < 2

    colors = arguments[0]
    error_message = arguments[1]

    fg_colors_keys = lookupvar('::colorprompt::fg_colors').keys
    bg_colors_keys = lookupvar('::colorprompt::bg_colors').keys
    styles_keys = lookupvar('::colorprompt::styles').keys

    case colors
    when String
      unless fg_colors_keys.include?(colors)
        raise(Puppet::ParseError, "validate_colors(): #{error_message} '#{colors}' not found in array '#{fg_colors_keys}'!")
      end
    when Array
      if colors.size == 0 or colors.size > 3
        raise(Puppet::ParseError, 'validate_colors(): Size array of colors must be not equal 0 and more 3!')
      else
        unless fg_colors_keys.include?(colors[0])
          raise(Puppet::ParseError, "validate_colors(): #{error_message} '#{colors[0]}' not found in array '#{fg_colors_keys}'!")
        end
        if colors[1]
          unless bg_colors_keys.include?(colors[1])
            raise(Puppet::ParseError, "validate_colors(): #{error_message} '#{colors[1]}' not found in array '#{bg_colors_keys}'!")
          end
        end
        if colors[2]
          unless styles_keys.include?(colors[2])
            raise(Puppet::ParseError, "validate_colors(): #{error_message} '#{colors[2]}' not found in array '#{styles_keys}'!")
          end
        end
      end
    else
      raise(Puppet::ParseError, 'validate_colors(): Requires array or string in first argumnet to work with!')
    end
  end
end

# vim: set ts=2 sw=2 et :
