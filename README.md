[![Build Status](https://travis-ci.org/github/issoupadrink/Simple-Repetition-Suppression.svg?branch=master)](https://travis-ci.org/github/issoupadrink/Simple-Repetition-Suppression)
[![codecov](https://codecov.io/gh/issoupadrink/Simple-Repetition-Suppression/branch/master/graph/badge.svg)](https://codecov.io/gh/issoupadrink/Simple-Repetition-Suppression)

# Simple Repetition Suppression

Simple Repetition Suppression is a lossless algorithm for basic data compression where a substring containing `n` repeated tokens are replaced with a special flag indicating the character and number of occurrences. For example, `abbbbc` would become `a\b4c` reducing the size of the string by one character. For larger files with many repeated characters, such as a jpeg or sparce matrices, this can be a simple way to reduce the size quickly. 

As a fun and topical test I ran this algorithm against the COVID-19 genome, however because it only really benefits cases where a character is repeated numerous times back-to-back the compression only offers a laughable ~5% reduction in size!
