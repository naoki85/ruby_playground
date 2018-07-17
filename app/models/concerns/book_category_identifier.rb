module BookCategoryIdentifier
  def self.identify(word)
    return 'Ruby' if word =~ /(ruby)/i
    return 'PHP' if word =~ /(php)/i
    return 'Python' if word =~ /(python)/i
    return 'JavaScript' if word =~ /(javascript)/i
    return 'Java' if word =~ /(java)/i
    return 'Swift' if word =~ /(swift)/i
    return 'Kotlin' if word =~ /(kotlin)/i
    'Unspecified'
  end
end