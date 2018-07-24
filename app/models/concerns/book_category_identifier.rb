module BookCategoryIdentifier
  def self.identify(word)
    return 'Deep Learning' if word =~ /(deep\s?learning)/i
    return 'Ruby' if word =~ /(ruby)/i
    return 'PHP' if word =~ /(php)/i
    return 'Python' if word =~ /(python)/i
    return 'JavaScript' if word =~ /(javascript)/i
    return 'Java' if word =~ /(java)/i
    return 'Swift' if word =~ /(swift)/i
    return 'Kotlin' if word =~ /(kotlin)/i
    return 'Unity' if word =~ /(unity)/i
    return 'MySQL' if word =~ /(mysql)/i
    return 'Linux' if word =~ /(linux)/i
    return 'Apache' if word =~ /(apache)/i
    return 'C++' if word =~ /(C\+\+)/i
    return 'Go' if word =~ /(go)/i
    'Unspecified'
  end
end