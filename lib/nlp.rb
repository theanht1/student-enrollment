###
# This module is for Natural Language Processing related stuff
#

module NLP
  ##
  # Vietnamese module
  #
  def self.vi raw
    vi = YAML::load_file('lib/lang/vi.yml')
    encoding_options = {
      # Replace invalid byte sequences
      :invalid  => :replace,
      # Use a blank for those replacements
      :replace => "",
      # Always break lines with \n
      # For any character that isn't defined in ASCII, run this
      # code to find out how to replace it
      :universal_newline => true,
      :fallback => lambda { |char|
        # If no replacement is specified, use an empty string
        vi.fetch(char, "")
      }
    }

    raw.encode(Encoding.find('ASCII'), encoding_options)
  end

  ##
  # Generate uname (e.g: ha-noi, au-co)
  #
  # @param [String] raw
  #   The raw string want to be transformed
  # @param [Symbol] mod
  #   The translate module (e.g :vi, :jp)
  #
  # @example
  #   uname('Âu Cơ') #=> 'au-co'
  #   uname('Hạ Long') #=> 'ha-long'
  #
  def self.uname raw, mod
    processed = self.send(mod, raw)
    processed.downcase.gsub('-', '').split.join("-")
  end
end
