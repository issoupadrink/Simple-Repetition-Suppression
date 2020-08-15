require_relative 'simple_repetition_suppression'
require 'test/unit'

class TestCompression < Test::Unit::TestCase
    def test_duplicate_in_middle_of_string
        assert_equal('a/b3c', SimpleRepetitionSuppression.compress('abbbc'))
    end

    def test_duplicate_at_end_of_string
        assert_equal('ab/c2', SimpleRepetitionSuppression.compress('abcc'))
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
        assert_equal('a//2', SimpleRepetitionSuppression.compress('a//'))
    end
end

class TestDecompression < Test::Unit::TestCase
    def test_simple
        assert_equal('abbbc', SimpleRepetitionSuppression.decompress('a/b3c'))
    end

    def test_duplicate_at_end_of_string
        assert_equal('abcc', SimpleRepetitionSuppression.decompress('ab/c2'))
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
        assert_equal('a//', SimpleRepetitionSuppression.decompress('a//2'))
    end
end