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

            elsif c != previous_char && instances > 2
                result.concat('/' + previous_char + instances.to_s)
                instances = 1
                previous_char = c

            elsif c != previous_char && instances == 2
                result.concat(previous_char + previous_char)
                instances = 1
                previous_char = c

            else
                result.concat(previous_char)
                previous_char = c
            end
        end

        return result
    end

    def self.uncompress(text)
        input_stream = text.split('')
        result = ''

        if input_stream.length == 0
            return ''
        end

        unrolling = false
        duplicate_char = ''
        times_repeated = 0

        for i in 0..input_stream.length - 1
            c = input_stream[i]

            if unrolling && (duplicate_char.empty? || duplicate_char.nil?)
                # Get repeated character
                duplicate_char = c
                next

            elsif unrolling
                # Get number of times repeated
                times_repeated = c

                times_repeated.to_i.times do
                    result.concat(duplicate_char)
                end

                # Reset variables
                duplicate_char = ''
                instances = 0
                unrolling = false
                next
            end

            if c == '/'
                unrolling = true
                next
            else
                result.concat(c)
            end
        end

        return result
    end
end