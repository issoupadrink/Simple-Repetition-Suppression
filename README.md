# Simple Repetition Suppression

Simple Repetition Suppression is a lossless algorithm for basic data compression where a substring containing `n` repeated tokens are replaced with a special flag indicating the character and number of occurrences. For example, `abbbbc` would become `a\b4c` reducing the size of the string by one character. For larger files with many repeated characters, such as a jpeg or sparce matrices, this can be a simple way to reduce the size quickly. 
