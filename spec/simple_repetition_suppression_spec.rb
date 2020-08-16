require 'simple_repetition_suppression'
require 'rspec'
require 'spec_helper'

describe SimpleRepetitionSuppression do
    describe ".compress" do
        context "given an empty string" do
            it "returns an empty string" do
                expect(SimpleRepetitionSuppression.compress('')).to eq('')
            end
        end

        context "given a single character" do 
            it "returns the single character" do
                expect(SimpleRepetitionSuppression.compress('a')).to eq('a')
            end
        end

        context "given a duplicate at the start of a string" do
            it "compresses the duplicate and returns the rest of the string too" do
                expect(SimpleRepetitionSuppression.compress('aaabc')).to eq('/a3bc')
            end
        end

        context "given a duplicate in the middle of a string" do
            it "compresses the duplicate and returns the rest of the string too" do 
                expect(SimpleRepetitionSuppression.compress('abbbc')).to eq('a/b3c')
            end
        end

        context "given a duplicate at the end of a string" do 
            it "compresses the duplicate and returns the rest of the string too" do 
                expect(SimpleRepetitionSuppression.compress('abccc')).to eq('ab/c3')
            end
        end

        context "given a string containing the special flag character" do
            it "compresses the special character correctly" do
                expect(SimpleRepetitionSuppression.compress('a///')).to eq('a//3')
            end
        end
    end

    describe ".uncompress" do
        context "given an empty string" do
            it "returns an empty string" do
                expect(SimpleRepetitionSuppression.uncompress('')).to eq('')
            end
        end

        context "given a single character" do 
            it "returns the single character" do
                expect(SimpleRepetitionSuppression.uncompress('a')).to eq('a')
            end
        end

        context "given a duplicate at the start of a string" do
            it "uncompresses the duplicate and returns the rest of the string too" do
                expect(SimpleRepetitionSuppression.uncompress('/a3bc')).to eq('aaabc')
            end
        end

        context "given a duplicate in the middle of a string" do
            it "uncompresses the duplicate and returns the rest of the string too" do 
                expect(SimpleRepetitionSuppression.uncompress('a/b3c')).to eq('abbbc')
            end
        end

        context "given a duplicate at the end of a string" do 
            it "uncompresses the duplicate and returns the rest of the string too" do 
                expect(SimpleRepetitionSuppression.uncompress('ab/c3')).to eq('abccc')
            end
        end

        context "given a string containing the special flag character" do
            it "uncompresses the special character correctly" do
                expect(SimpleRepetitionSuppression.uncompress('a//3')).to eq('a///')
            end
        end
    end

    describe "integration tests" do
        context "given a large genome" do
            it "is lossless" do 
                covid_genome = File.read(RSPEC_ROOT + '/resources/covid_2019_genome.txt')
                compressed_string = SimpleRepetitionSuppression.compress(covid_genome)
        
                expect(SimpleRepetitionSuppression.uncompress(compressed_string)).to eq covid_genome
            end
        end

        context "given a large genome" do
            it "actually reduces the overall size" do
                covid_genome = File.read(RSPEC_ROOT + '/resources/covid_2019_genome.txt')
                compressed_string = SimpleRepetitionSuppression.compress(covid_genome)

                expect(compressed_string.length).to be < covid_genome.length
            end
        end
    end
end
