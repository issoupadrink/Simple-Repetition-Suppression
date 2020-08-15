require_relative 'simple_repetition_suppression'
require 'test/unit'

class TestCompression < Test::Unit::TestCase
    def test_duplicate_in_middle_of_string
        assert_equal('a/b3cc', SimpleRepetitionSuppression.compress('abbbcc'))
    end

    def test_duplicate_at_end_of_string
        assert_equal('ab/c3', SimpleRepetitionSuppression.compress('abccc'))
    end

    def test_duplicate_at_start_of_string
        assert_equal('/a3bc', SimpleRepetitionSuppression.compress('aaabc'))
    end

    def test_empty_string
        assert_equal('', SimpleRepetitionSuppression.compress(''))
    end

    def test_single_character
        assert_equal('a', SimpleRepetitionSuppression.compress('a'))
    end

    def test_with_special_character
        assert_equal('a//3', SimpleRepetitionSuppression.compress('a///'))
    end
end

class TestDecompression < Test::Unit::TestCase
    def test_duplicate_in_middle_of_string
        assert_equal('abbbcc', SimpleRepetitionSuppression.decompress('a/b3cc'))
    end

    def test_duplicate_at_end_of_string
        assert_equal('abccc', SimpleRepetitionSuppression.decompress('ab/c3'))
    end

    def test_duplicate_at_start_of_string
        assert_equal('aaabc', SimpleRepetitionSuppression.decompress('/a3bc'))
    end

    def test_empty_string
        assert_equal('', SimpleRepetitionSuppression.decompress(''))
    end

    def test_single_character
        assert_equal('a', SimpleRepetitionSuppression.decompress('a'))
    end

    def test_with_special_character
        assert_equal('a///', SimpleRepetitionSuppression.decompress('a//3'))
    end
end

class TestAgainstCovidGenome < Test::Unit::TestCase
    
    def test_lossless_decompression
        covid_genome = File.read('covid_2019_genome.txt')
        compressed_string = SimpleRepetitionSuppression.compress(covid_genome)

        assert_equal(covid_genome, SimpleRepetitionSuppression.decompress(compressed_string))
    end

    def test_compression_reduces_size
        covid_genome = File.read('covid_2019_genome.txt')
        compressed_string = SimpleRepetitionSuppression.compress(covid_genome)

        puts compressed_string.length
        puts covid_genome.length
        assert_true(compressed_string.length < covid_genome.length)
    end
end