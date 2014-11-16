namespace :db do
  namespace :seed do
    task :politicians => [:environment] do
      require 'csv'

      file = File.expand_path(ENV['FILE'])
      raise 'You must supply a FILE argument' if file.blank?

      CSV.foreach(file, headers: true) do |row|
        hash = row.to_hash
        Politician.create(hash)
      end

    end
  end
end