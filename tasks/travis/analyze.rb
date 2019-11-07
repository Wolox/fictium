namespace :travis do
  desc 'Analizes code quality, for TravisCI'
  task analyze: %i[spec travis:rubocop travis:brakeman]

  task :rubocop do
    Bundler.clean_exec('rubocop')
  end

  task :brakeman do
    Bundler.clean_exec('brakeman bundle exec brakeman --no-pager --exit-on-error')
  end
end
