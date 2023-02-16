module Selection
  def get_user_genre(msg, genres)
    genres.list_all_genres
    print msg
    index = gets.chomp.to_i
    if index <= genres.genres.length && index.positive?
      genres.genres[index - 1]
    else
      puts red('Invalid index')
      get_user_genre(msg, genres)
    end
  end

  def get_user_author(msg, authors)
    authors.list_all_authors
    print msg
    index = gets.chomp.to_i
    if index <= authors.authors.length && index.positive?
      authors.authors[index - 1]
    else
      puts red('Invalid index')
      get_user_author(msg, authors)
    end
  end

  def get_user_label(msg, labels)
    labels.list_all_labels
    print msg
    index = gets.chomp.to_i
    if index <= labels.labels.length && index.positive?
      labels.labels[index - 1]
    else
      puts red('Invalid index')
      get_user_label(msg, labels)
    end
  end

  def valid_date?(date_string)
    Date.parse(date_string)
    true
  rescue ArgumentError
    false
  end

  def get_user_date(msg)
    date = get_user_string(msg)
    if valid_date?(date)
      date
    else
      puts red('Invalid date')
      get_user_date(msg)
    end
  end

  def get_user_string(msg)
    print cyan(msg)
    gets.chomp
  end
end
