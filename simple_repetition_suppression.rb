class SimpleRepetitionSuppression

    def self.compress(text)
        input_stream = text.split('')
        result = ''

        previous_char = ''
        instances = 1

        if input_stream.length == 0
            return ''
        end

        for i in 0..input_stream.length
            c = input_stream[i]
            if c == previous_char
                instances += 1
            elsif c != previous_char && instances > 1
                result.concat('/' + previous_char + instances.to_s)
                instances = 1
                previous_char = c
            else
                result.concat(previous_char)
                previous_char = c
            end
        end

        return result
    end

    def self.decompress(text)
        chars = text.split('')
        chars.each { |c|
            puts c
        }
    end

end